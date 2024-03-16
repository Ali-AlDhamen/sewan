import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/core/utils/show_toast.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/quiz/repository/quiz_repository.dart';
import 'package:sewan/features/quiz/state/online_quiz_session.dart';
import 'package:sewan/router/app_router.dart';
import 'package:uuid/uuid.dart';

final quizControllerProvider =
    StateNotifierProvider<QuizController, AsyncValue<void>>((ref) {
  return QuizController(
    quizRepository: ref.watch(quizRepositoryProvider),
    ref: ref,
  );
});

final onlineQuizSessionProvider = StreamProvider.family<OnlineQuizSession, String>((ref, sessionId) {
  final quizController = ref.watch(quizControllerProvider.notifier);
  return quizController.getOnlineQuizSession(sessionId);
});

class QuizController extends StateNotifier<AsyncValue<void>> {
  final QuizRepository _quizRepository;
  final Ref _ref;
  QuizController({
    required QuizRepository quizRepository,
    required Ref ref,
  })  : _quizRepository = quizRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  void createQuizSession({
    required List<Question> questions,
    required String courseId,
    required String lectureId,
    required BuildContext context,
  }) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    state = const AsyncLoading();
    final OnlineQuizSession quizSession = OnlineQuizSession(
      id: const Uuid().v4(),
      player1Id: userId,
      player2Id: '',
      player1Answers: {},
      player2Answers: {},
      questions: questions,
      currentQuestionIndex: 0,
      courseId: courseId,
      lectureId: lectureId,
    );
    final res = await _quizRepository.createQuizSession(quizSession);
    state = const AsyncValue.data(null);
    res.fold(
      (l) => showToast(
        context: context,
        message: l.message,
        type: ToastType.error,
      ),
      (r) => _ref.read(goRouterProvider).push('/room/${quizSession.id}'),
    );
  }

  Stream<OnlineQuizSession> getOnlineQuizSession(String sessionId) {
    return _quizRepository.getOnlineQuizSession(sessionId);
  }

  void joinOnlineQuizSession({
    required String sessionId,
    required BuildContext context,
  }) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    state = const AsyncLoading();
    final res = await _quizRepository.joinOnlineQuizSession(sessionId, userId);
    state = const AsyncValue.data(null);
    res.fold(
      (l) => showToast(
        context: context,
        message: l.message,
        type: ToastType.error,
      ),
      (r) => _ref.read(goRouterProvider).push('/room/$sessionId'),
    );
  }

  void nextQuestion({
    required String sessionId,
    required BuildContext context,
  }) async {
    final res = await _quizRepository.nextQuestion(sessionId);
    res.fold(
      (l) => showToast(
        context: context,
        message: l.message,
        type: ToastType.error,
      ),
      (r) {},
    );
  }

  void submitAnswer({
    required String sessionId,
    required int playerId,
    required String questionId,
    required String answer,
    required BuildContext context,
  }) async {
    final res = await _quizRepository.submitAnswer(
      sessionId: sessionId,
      playerId: playerId,
      questionId: questionId,
      answer: answer,
    );
    res.fold(
      (l) => showToast(
        context: context,
        message: l.message,
        type: ToastType.error,
      ),
      (r) {},
    );
  }
}
