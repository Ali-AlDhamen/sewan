import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/question.dart';

enum QuizStatus { initial, correct, incorrect, complete }

final quizStateProvider = Provider((ref) => QuizState.initial());

class QuizState {
  final String selectedAnswer;
  final List<Question> questions;
  final List<Question> correct;
  final List<Question> incorrect;
  final QuizStatus status;
  final int questionNumber;
  final PageController pageController;
  final bool isNew;
  final bool isSaved;
  final int timer;

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState({
    required this.questions,
    required this.selectedAnswer,
    required this.correct,
    required this.incorrect,
    required this.status,
    required this.questionNumber,
    required this.pageController,
    required this.isNew,
    required this.isSaved,
    required this.timer
  });

  factory QuizState.initial() {
    return QuizState(
      questions: [],
      selectedAnswer: '',
      correct: [],
      incorrect: [],
      status: QuizStatus.initial,
      questionNumber: 0,
      pageController: PageController(),
      isNew: false,
      isSaved: false,
      timer: 30
    );
  }

  List<Object> get props => [
        selectedAnswer,
        correct,
        incorrect,
        status,
      ];

  QuizState copyWith({
    List<Question>? questions,
    String? selectedAnswer,
    List<Question>? correct,
    List<Question>? incorrect,
    QuizStatus? status,
    int? questionNumber,
    PageController? pageController,
    bool? isNew,
    bool? isSaved,
    int? timer
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      status: status ?? this.status,
      questionNumber: questionNumber ?? this.questionNumber,
      pageController: pageController ?? this.pageController,
      isNew: isNew ?? this.isNew,
      isSaved: isSaved ?? this.isSaved,
      timer: timer ?? this.timer,
    );
  }

  bool get isStarted => questionNumber >= 1;

  @override
  String toString() {
    return 'QuizState(questions: $questions )';
  }
}
