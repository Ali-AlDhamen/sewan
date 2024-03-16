import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sewan/core/providers/firebase_providers.dart';
import 'package:sewan/core/types/failure.dart';
import 'package:sewan/core/types/future_either.dart';
import 'package:sewan/features/quiz/state/online_quiz_session.dart';


final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository(
    firestore: ref.watch(firestoreProvider),
  );
});
class QuizRepository {
  final FirebaseFirestore _firestore;
  QuizRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _quizSessions =>
      _firestore.collection('quizSessions');

  FutureVoid createQuizSession(OnlineQuizSession session) async {
    try {
      return right(_quizSessions.doc(session.id).set(session.toMap()));
    } on FirebaseException catch (e) {
      return left(
        Failure(e.toString()),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  FutureVoid joinOnlineQuizSession(String sessionId, String player2Id) async {
    try {
      return right(_quizSessions.doc(sessionId).update({
        'player2Id': player2Id,
      }));
    } on FirebaseException catch (e) {
      return left(
        Failure(e.toString()),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  Stream<OnlineQuizSession> getOnlineQuizSession (String sessionId) {
    return _quizSessions.doc(sessionId).snapshots().map((event) => OnlineQuizSession.fromMap(event.data() as Map<String, dynamic>));
  }


  FutureVoid nextQuestion(String sessionId) async {
    try{
      return right(_quizSessions.doc(sessionId).update({
        'currentQuestionIndex': FieldValue.increment(1),
      }));
    } on FirebaseException catch (e) {
      return left(
        Failure(e.toString()),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  FutureVoid submitAnswer({
    required String sessionId,
    required int playerId,
    required String questionId,
    required String answer,
  
  }) async {
    try{
      final session = await _quizSessions.doc(sessionId).get();
      final data = session.data() as Map<String, dynamic>;
      final playerAnswers = data['player${playerId}Answers'] as Map<String, dynamic>;
      final newPlayerAnswers = Map<String, dynamic>.from(playerAnswers);
      newPlayerAnswers[questionId] = answer;

      return right(_quizSessions.doc(sessionId).update({
        'player${playerId}Answers': newPlayerAnswers,
      }));
    } on FirebaseException catch (e) {
      return left(
        Failure(e.toString()),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }


}
