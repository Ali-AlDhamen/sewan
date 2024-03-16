import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/get_lecture_params.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/quiz/controller/quiz_controller.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';

class QuizSettingsScreen extends ConsumerStatefulWidget {
  final String lectureId;
  final String courseId;
  const QuizSettingsScreen(
      {super.key, required this.lectureId, required this.courseId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends ConsumerState<QuizSettingsScreen> {
  final TextEditingController _numberOfQuestionsController =
      TextEditingController();
  final TextEditingController _timerController = TextEditingController();

  bool trueFalse = false;
  bool multipleChoice = false;

  String selectedMode = "Classic";

  List<Question> getRandomQuestions(int number, List<Question> questions) {
    // Check if the requested number of questions is more than the available questions
    if (number >= questions.length) {
      return List<Question>.from(questions); // Return a copy of all questions
    }

    // Create a new random generator
    final _random = Random();

    // Create an empty list for randomly selected questions
    List<Question> randomQuestions = [];

    // Keep track of already selected indices to avoid duplicates
    Set<int> selectedIndices = {};

    // Select random questions
    while (randomQuestions.length < number) {
      // Generate a random index
      int index = _random.nextInt(questions.length);

      // Check if the index has already been used
      if (!selectedIndices.contains(index)) {
        // If not, add the question at that index to the random questions list
        randomQuestions.add(questions[index]);
        // Remember this index so it won't be used again
        selectedIndices.add(index);
      }
    }

    return randomQuestions;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Settings'),
        ),
        body: ref
            .watch(lectureProvider(GetLectureParams(
                courseId: widget.courseId, lectureId: widget.lectureId)))
            .when(
              data: (data) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Number of Questions (max ${data.questions.length})',
                                  style: const TextStyle(fontSize: 14)),
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _numberOfQuestionsController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Timer for each question (in seconds)',
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _timerController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.grey,
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('True/False Questions',
                                  style: TextStyle(fontSize: 14)),
                              Switch(
                                value: trueFalse,
                                onChanged: (value) {
                                  setState(() {
                                    trueFalse = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Multiple Choice Questions',
                                  style: TextStyle(fontSize: 14)),
                              Switch(
                                value: multipleChoice,
                                onChanged: (value) {
                                  setState(() {
                                    multipleChoice = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.grey,
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMode = "Classic";
                                      });
                                    },
                                    child: Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // deep purple borders
                                          border: Border.all(
                                            color: selectedMode == "Classic"
                                                ? Colors.deepPurple
                                                : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.book,
                                          color: selectedMode == "Classic"
                                              ? Colors.deepPurple
                                              : Colors.grey,
                                          size: 50,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Classic Mode',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedMode == "Classic"
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMode = "1v1";
                                      });
                                    },
                                    child: Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // deep purple borders
                                          border: Border.all(
                                            color: selectedMode == "1v1"
                                                ? Colors.deepPurple
                                                : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.people,
                                          color: selectedMode == "1v1"
                                              ? Colors.deepPurple
                                              : Colors.grey,
                                          size: 50,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '1v1 Mode',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedMode == "1v1"
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMode = "Survival";
                                      });
                                    },
                                    child: Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // deep purple borders
                                          border: Border.all(
                                            color: selectedMode == "Survival"
                                                ? Colors.deepPurple
                                                : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.timer,
                                          color: selectedMode == "Survival"
                                              ? Colors.deepPurple
                                              : Colors.grey,
                                          size: 50,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Survival Mode',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedMode == "Survival"
                                          ? Colors.deepPurple
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(15),
                              ),
                              onPressed: () {
                                if (selectedMode == '1v1') {
                                  ref
                                      .read(quizControllerProvider.notifier)
                                      .createQuizSession(
                                        questions: getRandomQuestions(
                                          int.parse(
                                              _numberOfQuestionsController.text),
                                          data.questions,
                                        ),
                                        courseId: widget.courseId,
                                        lectureId: widget.lectureId,
                                        context: context,
                                      );
                                } else {
                                  ref
                                      .read(quizStateControllerProvider.notifier)
                                      .loadTimer(
                                        int.parse(
                                          _timerController.text.trim(),
                                        ),
                                      );
                                  ref
                                      .read(quizStateControllerProvider.notifier)
                                      .loadQuestions(
                                        getRandomQuestions(
                                          int.parse(
                                              _numberOfQuestionsController.text),
                                          data.questions,
                                        ),
                                        ref,
                                      );
                                }
                              },
                              child: const Text('Generate Quiz',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
      ),
    );
  }
}
