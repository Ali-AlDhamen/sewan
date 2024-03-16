import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/course_model.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/get_lecture_params.dart';
import 'package:sewan/core/models/lecture_model.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/core/services/openai_services.dart';
import 'package:sewan/core/utils/show_toast.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/flashcards/repository/flashcards_repository.dart';
import 'package:sewan/router/app_router.dart';

import 'package:uuid/uuid.dart';

final flashCardsControllerProvider =
    StateNotifierProvider<FlashCardsController, AsyncValue<void>>((ref) {
  return FlashCardsController(
    flashCardsRepository: ref.watch(flashCardsRepositoryProvider),
    ref: ref,
  );
});

final userCoursesProvider = FutureProvider<List<CourseModel>>((ref) {
  final flashCardsController = ref.watch(flashCardsControllerProvider.notifier);
  return flashCardsController.getCourses();
});

final courseLecturesProvider =
    FutureProvider.family<CourseModel, String>((ref, courseId) {
  final flashCardsController = ref.watch(flashCardsControllerProvider.notifier);
  return flashCardsController.getCourseLectures(courseId);
});

final lectureProvider = FutureProvider.family<LectureModel, GetLectureParams>(
    (ref, params) {
  final flashCardsController = ref.watch(flashCardsControllerProvider.notifier);
  return flashCardsController.getLecture(params.courseId, params.lectureId);
});

class FlashCardsController extends StateNotifier<AsyncValue<void>> {
  final FlashCardsRepository _flashCardsRepository;
  final Ref _ref;
  FlashCardsController(
      {required FlashCardsRepository flashCardsRepository, required Ref ref})
      : _flashCardsRepository = flashCardsRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

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
            ), (r) {
      showToast(
        context: context,
        message: 'Course Created Successfully',
        type: ToastType.success,
      );

      _ref.read(goRouterProvider).goNamed('course screen', pathParameters: {
        'courseId': course.id,
      });
    });
  }

  Future<List<CourseModel>> getCourses() async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result = await _flashCardsRepository.getCourses(userId);
    return result;
  }

  Future<void> uploadLecture(
      {required String title,
      required BuildContext context,
      required String courseId,
      required String fileText}) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    state = const AsyncLoading();
    List<FlashCardModel> flashcards = [];
    List<Question> questions = [];
    final openaiResponses = await _ref
        .read(openAIServicesProvider)
        .generateFlashCards(text: fileText);
    openaiResponses.fold((l) {
      showToast(
        context: context,
        message: l.message,
        type: ToastType.error,
      );
    }, (r) {
      (flashcards, questions) = r;
    });

    final LectureModel lecture = LectureModel(
      courseId: courseId,
      userId: userId,
      title: title,
      id: const Uuid().v4(),
      flashCards: flashcards,
      questions: questions,
    );
    final result = await _flashCardsRepository.uploadLecture(lecture);
    state = const AsyncValue.data(null);
    result.fold(
        (l) => showToast(
              context: context,
              message: l.message,
              type: ToastType.error,
            ),
        (r) {});
  }

  Future<CourseModel> getCourseLectures(String courseId) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result =
        await _flashCardsRepository.getCourseLectures(userId, courseId);
    return result;
  }

  Future<LectureModel> getLecture(String courseId, String lectureId) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result = await _flashCardsRepository.getLecture(
      userId: userId,
      lectureId: lectureId,
      courseId: courseId,
    );
    return result;
  }

  Future<void> changeFlashCardStatus({
    required String courseId,
    required String lectureId,
    required FlashCardModel flashCardModel,
    required BuildContext context,
  }) async {
    final userId = _ref.read(userProvider)?.id ?? '';
    final result = await _flashCardsRepository.changeFlashCardStatus(
      userId: userId,
      courseId: courseId,
      lectureId: lectureId,
      flashCardModel: flashCardModel,
    );
    result.fold(
      (l) => showToast(
        context:  context,
        message: l.message,
        type: ToastType.error,
      ),
      (r) {},
    );
  }
}
