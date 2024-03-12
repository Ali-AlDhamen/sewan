import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:uuid/uuid.dart';

final openAIServicesProvider = Provider<OpenAIServices>((ref) {
  return OpenAIServices();
});

class OpenAIServices {
  Future<List<FlashCardModel>> generateFlashCards({
    required String text,
  }) async {
     OpenAI.apiKey = dotenv.env["OPENAI_API_KEY"]!; 
        const TEMPLATE = """{
    "flashcards": [
        {
        "term": "What is the purpose of assembler directives?",
        "definition": "To provide information to the assembler"
        },
        {
        "term": "What are opcodes?",
        "definition": "Mnemonic codes representing specific machine instructions"
        }
    ]
    }""";

      final SystemPrompt = """
        Act as teacher and create a unique flashcards based on the text delimted by four backquotes,
        the response must be formatted in JSON. Each flashcard contains, term, definition. MAKE SURE THE flashcards ARE UNIQUE AND FROM THE PROVIDED DELIMTTED TEXT.
        this is an example of the response: $TEMPLATE
        """;
    final messages = [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(SystemPrompt)
        ],
        role: OpenAIChatMessageRole.system,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text( 'the text is : ````$text````',)
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ];

    final chat = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-16k",
      messages: messages,
    );

    final flashCards = chat.choices.first.message.content?.first.text ?? '';
    print(flashCards);
    final flashCardJson = jsonDecode(flashCards)['flashcards'];

    final List<FlashCardModel> flashCardList = flashCardJson
        .map<FlashCardModel>((e) => FlashCardModel(
              id: const Uuid().v4(),
              term: e['term'],
              definition: e['definition'],
              status: FlashCardStatus.notStarted,
            ))
        .toList();
    return flashCardList;
  }
}