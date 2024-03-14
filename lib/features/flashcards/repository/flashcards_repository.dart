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
      print(lecture.toMap());
      return right(_users
          .doc(lecture.userId)
          .collection(FirebaseConstants.coursesCollection)
          .doc(lecture.courseId)
          .update({
        'lectures': FieldValue.arrayUnion([lecture.toMap()])
      }));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid createCourse(CourseModel course) async {
    try {
      return right(_users
          .doc(course.userId)
          .collection(FirebaseConstants.coursesCollection)
          .doc(course.id)
          .set(course.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<CourseModel>> getCourses(String userId) async {
    final snapshot = await _users
        .doc(userId)
        .collection(FirebaseConstants.coursesCollection)
        .get();
    return snapshot.docs.map((e) => CourseModel.fromMap(e.data())).toList();
  }

  Future<CourseModel> getCourseLectures(
      String userId, String courseId) async {
    try {
      final snapshot = await _users
          .doc(userId)
          .collection(FirebaseConstants.coursesCollection)
          .doc(courseId).get();
      return CourseModel.fromMap(snapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw Failure(e.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  
  Future<LectureModel> getLecture({required String userId, required String lectureId, required String courseId}) async {
    try {
      final snapshot = await _users
          .doc(userId)
          .collection(FirebaseConstants.coursesCollection)
          .doc(courseId)
          .get();
      
      final course =  CourseModel.fromMap(snapshot.data() as Map<String, dynamic>);
      final lecture = course.lectures.firstWhere((element) => element.id == lectureId);
      return lecture;
    } on FirebaseException catch (e) {
      throw Failure(e.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
