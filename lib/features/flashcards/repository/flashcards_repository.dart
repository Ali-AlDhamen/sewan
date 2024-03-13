import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sewan/core/constants/firebase_constants.dart';
import 'package:sewan/core/models/course_model.dart';
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

  CollectionReference get _lectures =>
      _firestore.collection(FirebaseConstants.lecturesCollection);
  
  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  
  



  FutureVoid uploadLecture(LectureModel lecture) async {
    try {
      return right(
        _users.doc(lecture.userId).collection(FirebaseConstants.lecturesCollection).doc(lecture.id).set(lecture.toMap())
      );
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid createCourse(CourseModel course) async{
    try {
      return right(
        _users.doc(course.userId).collection(FirebaseConstants.coursesCollection).doc(course.id).set(course.toMap())
      );
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
      
    }
  }

  Future<List<CourseModel>> getCourses(String userId) async {
    try {
      final snapshot = await _users.doc(userId).collection(FirebaseConstants.coursesCollection).get();
      return snapshot.docs.map((e) => CourseModel.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      throw Failure(e.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<LectureModel>> getCourseLectures(String userId, String courseId) async {
    try {
      final snapshot = await _users.doc(userId).collection(FirebaseConstants.coursesCollection).doc(courseId).collection(FirebaseConstants.lecturesCollection).get();
      return snapshot.docs.map((e) => LectureModel.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      throw Failure(e.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  FutureVoid addFlashCard({required String lectureId ,required List<FlashCardModel> flashCards}) async {
    try {
      return right(await _lectures.doc(lectureId).update({
        'flashCards': FieldValue.arrayUnion(flashCards.map((e) => e.toMap()).toList())
      }));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
