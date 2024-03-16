import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/core/types/failure.dart';
import 'package:sewan/core/types/future_either.dart';
import 'package:uuid/uuid.dart';

final openAIServicesProvider = Provider<OpenAIServices>((ref) {
  return OpenAIServices();
});

class OpenAIServices {
  FutureEither<(List<FlashCardModel> , List<Question>)> generateFlashCards({
    required String text,
  }) async {
    print(text.length);
    OpenAI.apiKey = dotenv.env["OPENAI_API_KEY"]!;
    OpenAI.requestsTimeOut = const Duration(seconds: 500);
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

    const QUIZTEMPLETE = """
"questions": [
  {
    "question": "where is saudi arabia",
    "choices": [
      "middle east",
      "africa",
      "asia",
      "europe"]
    "answer": "middle east"
  },
  {
    "question": "where is india",
    "choices": [
      "middle east",
      "africa",
      "asia",
      "europe"]
    "answer": "asia"
  }
]
""";

    final SystemPrompt = """
        Act as teacher and create 100 unique flashcards as you can based on the text delimted by four backquotes,
        the response must be formatted in JSON. Each flashcard contains, term, definition. MAKE SURE THE flashcards ARE UNIQUE AND FROM THE PROVIDED DELIMTTED TEXT.
        this is an example of the response: $TEMPLATE
        """;

    final SystemPromptQuestions = """
        Act as teacher and create 100 unique questions as you can based on the text delimted by four backquotes,
        the response must be formatted in JSON. Each question contains, question , choices and answer limit ur choices must be 4 and answer to just one of the choices MAKE SURE THE questions ARE UNIQUE AND FROM THE PROVIDED DELIMTTED TEXT.
        this is an example of the response: $QUIZTEMPLETE answer should be in the choices only!!
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
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            'the text is : ````$text````',
          )
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ];
    final messagesQuestions = [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            SystemPromptQuestions,
          )
        ],
        role: OpenAIChatMessageRole.system,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            'the text is : ````$text````',
          )
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ];
    try {
      final response = Future.wait([
        OpenAI.instance.chat.create(
          model: "gpt-3.5-turbo-16k",
          messages: messages,
        ),
        OpenAI.instance.chat.create(
          model: "gpt-3.5-turbo-16k",
          messages: messagesQuestions,
        ),
      ]);
      final chat = await response;
      print(chat[1]);

      final flashCards =
          chat[0].choices.first.message.content?.first.text ?? '';
      print(chat[0].usage);
      print(chat[1].usage);
      final flashCardJson = jsonDecode(flashCards)['flashcards'];

      final List<FlashCardModel> flashCardList = flashCardJson
          .map<FlashCardModel>((e) => FlashCardModel(
                id: const Uuid().v4(),
                term: e['term'],
                definition: e['definition'],
                status: FlashCardStatus.notStarted,
              ))
          .toList();

      final questions = chat[1].choices.first.message.content?.first.text ?? '';
      final questionsJson = jsonDecode(questions)['questions'];
      print(questionsJson);
      final List<Question> questionsList = questionsJson.map<Question>((e) {
        return Question(
          id: const Uuid().v4(),
          question: e['question'] as String,
          choices: List<String>.from(e['choices'] as List),
          answer: e['answer'] as String,
        );
      }).toList();
      print(questionsList);
      return right((flashCardList, questionsList));
    } catch (e) {
      print(e.toString());
      return left(Failure(e.toString()));
    }
  }
}
