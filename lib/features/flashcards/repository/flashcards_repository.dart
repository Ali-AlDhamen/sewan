import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sewan/core/constants/firebase_constants.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/lecture_model.dart';
import 'package:sewan/core/providers/firebase_providers.dart';
import 'package:sewan/core/types/failure.dart';
import 'package:sewan/core/types/future_either.dart';


final flashCardsRepositoryProvider = Provider<FlashCardsRepository>((ref) {
  return FlashCardsRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class FlashCardsRepository {
  final FirebaseFirestore _firestore;
  FlashCardsRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _flashCards =>
      _firestore.collection(FirebaseConstants.lecturesCollection);

  FutureVoid uploadLecture(LectureModel lecture) async {
    try {
      return right(await _flashCards.doc(lecture.id).set(lecture.toMap()));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addFlashCard({required String lectureId ,required List<FlashCardModel> flashCards}) async {
    try {
      return right(await _flashCards.doc(lectureId).update({
        'flashCards': FieldValue.arrayUnion(flashCards.map((e) => e.toMap()).toList())
      }));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
