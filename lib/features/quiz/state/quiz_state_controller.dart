import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/router/app_router.dart';
import 'quiz_state.dart';

final quizStateControllerProvider =
    StateNotifierProvider<QuizStateController, QuizState>(
  (ref) => QuizStateController(),
);

class QuizStateController extends StateNotifier<QuizState> {
  QuizStateController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.answer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.correct..add(currentQuestion),
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        incorrect: state.incorrect..add(currentQuestion),
        status: QuizStatus.incorrect,
      );
    }
  }

  void loadQuestions(List<Question> questions, WidgetRef ref) {
    state = state.copyWith(
      questions: questions,
    );
    ref.read(goRouterProvider).pushNamed('quiz screen');
  }

  void loadTimer(int timer){
    state = state.copyWith(
      timer: timer,
    );
  }

  void nextQuestion(List<Question> questions) {
    print(state.questionNumber );
    print(state.questions);

    state = state.copyWith(
      selectedAnswer: '',
      status: state.questionNumber < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
      questionNumber: state.questionNumber + 1,
    );
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  void startQuiz(List<Question> questions) {
    state = state.copyWith(
      status: QuizStatus.initial,
    );
  }

  void isNewQuiz(bool status) {
    state = state.copyWith(
      isNew: status,
    );
  }

  void completeQuiz() {
    state = state.copyWith(status: QuizStatus.complete);
  }

  bool isQuizStarted() {
    return state.questions.isNotEmpty && state.status != QuizStatus.complete;
  }

  void reset() {
    state = QuizState.initial();
  }

  void saveQuiz() {
    state = state.copyWith(isSaved: true);
  }
}
