import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/quiz/state/quiz_state.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';


class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quizStateControllerProvider.notifier).completeQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizStateControllerProvider);
    final List<Question> correctQuestions = quizState.correct;
    final List<Question> incorrectQuestions = quizState.incorrect;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Your Score: ${quizState.correct.length}/${quizState.correct.length + quizState.incorrect.length}",
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Correct Questions:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (Question question in correctQuestions)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      question.question,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Incorrect Questions:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (Question question in incorrectQuestions)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      question.question,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0)),
                      onPressed: () {
                        context.go('/learn');
                        ref.read(quizStateControllerProvider.notifier).reset();
                      },
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}