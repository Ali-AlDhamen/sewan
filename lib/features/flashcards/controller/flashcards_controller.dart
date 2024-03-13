import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/course_model.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/lecture_model.dart';
import 'package:sewan/core/utils/show_toast.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/flashcards/repository/flashcards_repository.dart';

import 'package:uuid/uuid.dart';

final flashCardsControllerProvider =
    StateNotifierProvider<FlashCardsController, AsyncValue<void>>((ref) {
  return FlashCardsController(
    flashCardsRepository: ref.watch(flashCardsRepositoryProvider),
    ref: ref,
  );
});


final userCoursesProvider = FutureProvider.autoDispose<List<CourseModel>>((ref) {
  final flashCardsController = ref.watch(flashCardsControllerProvider.notifier);
  return flashCardsController.getCourses();
});

final courseLecturesProvider = FutureProvider.family.autoDispose<List<LectureModel>, String>((ref, courseId) {
  final flashCardsController = ref.watch(flashCardsControllerProvider.notifier);
  return flashCardsController.getCourseLectures(courseId);
});

class FlashCardsController extends StateNotifier<AsyncValue<void>> {
  final FlashCardsRepository _flashCardsRepository;
  final Ref _ref;
  FlashCardsController(
      {required FlashCardsRepository flashCardsRepository, required Ref ref})
      : _flashCardsRepository = flashCardsRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  void addFlashCard(
      {required String lectureId,
      required List<FlashCardModel> flashCards,
      required BuildContext context}) async {
    state = const AsyncLoading();
    final result = await _flashCardsRepository.addFlashCard(
        lectureId: lectureId, flashCards: flashCards);
    state = const AsyncValue.data(null);
    result.fold(
        (l) => showToast(
              context: context,
              message: l.message,
              type: ToastType.error,
            ),
        (r) {});
  }

  void createCourse({
    required String name,
    required BuildContext context,
  }) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    state = const AsyncLoading();

    final course = CourseModel(
      userId: userId,
      name: name,
      id: const Uuid().v4(),
      lectures: [],
    );

    final result = await _flashCardsRepository.createCourse(course);
    state = const AsyncValue.data(null);
    result.fold(
        (l) => showToast(
              context: context,
              message: l.message,
              type: ToastType.error,
            ),
        (r) {
          showToast(
            context: context,
            message: 'Course Created Successfully',
            type: ToastType.success,
          );
          context.pop();
        });
  }

  Future<List<CourseModel>> getCourses() async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result = await _flashCardsRepository.getCourses(userId);
    return result;
  }

  void uploadLecture(
      {required String title,
      required BuildContext context,
      required String courseId}) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    state = const AsyncLoading();
    final LectureModel lecture = LectureModel(
      courseId: courseId,
      userId: userId,
      title: title,
      id: const Uuid().v4(),
      flashCards: [],
    );
    final result = await _flashCardsRepository.uploadLecture(lecture);
    state = const AsyncValue.data(null);
    result.fold(
        (l) => showToast(
              context: context,
              message: l.message,
              type: ToastType.error,
            ),
        (r) {
          
        });
  }

  Future<List<LectureModel>> getCourseLectures(String courseId) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result = await _flashCardsRepository.getCourseLectures(userId, courseId);
    return result;
  }
}
