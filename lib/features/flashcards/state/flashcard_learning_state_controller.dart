// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/get_lecture_params.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/repository/flashcards_repository.dart';
import 'package:sewan/router/app_router.dart';

class FlashcardLearningState {
  final int currentIndex;
  final String id;
  final List<FlashCardModel> flashCards;
  final String courseId;
  final String lectureId;
  final String userId;
  final bool clicked;
  FlashcardLearningState({
    required this.currentIndex,
    required this.id,
    required this.flashCards,
    required this.courseId,
    required this.lectureId,
    required this.userId,
    required this.clicked,
  });
  

  FlashcardLearningState copyWith({
    int? currentIndex,
    String? id,
    List<FlashCardModel>? flashCards,
    String? courseId,
    String? lectureId,
    String? userId,
    bool? clicked,
  }) {
    return FlashcardLearningState(
      currentIndex: currentIndex ?? this.currentIndex,
      id: id ?? this.id,
      flashCards: flashCards ?? this.flashCards,
      courseId: courseId ?? this.courseId,
      lectureId: lectureId ?? this.lectureId,
      userId: userId ?? this.userId,
      clicked: clicked ?? this.clicked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentIndex': currentIndex,
      'id': id,
      'flashCards': flashCards.map((x) => x.toMap()).toList(),
      'courseId': courseId,
      'lectureId': lectureId,
      'userId': userId,
      'clicked': clicked,
    };
  }

  factory FlashcardLearningState.fromMap(Map<String, dynamic> map) {
    return FlashcardLearningState(
      currentIndex: map['currentIndex'] as int,
      id: map['id'] as String,
      flashCards: List<FlashCardModel>.from((map['flashCards'] as List<dynamic>).map<FlashCardModel>((x) => FlashCardModel.fromMap(x as Map<String,dynamic>),),),
      courseId: map['courseId'] as String,
      lectureId: map['lectureId'] as String,
      userId: map['userId'] as String,
      clicked: map['clicked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashcardLearningState.fromJson(String source) => FlashcardLearningState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FlashcardLearningState(currentIndex: $currentIndex, id: $id, flashCards: $flashCards, courseId: $courseId, lectureId: $lectureId, userId: $userId, clicked: $clicked)';
  }

  @override
  bool operator ==(covariant FlashcardLearningState other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentIndex == currentIndex &&
      other.id == id &&
      listEquals(other.flashCards, flashCards) &&
      other.courseId == courseId &&
      other.lectureId == lectureId &&
      other.userId == userId &&
      other.clicked == clicked;
  }

  @override
  int get hashCode {
    return currentIndex.hashCode ^
      id.hashCode ^
      flashCards.hashCode ^
      courseId.hashCode ^
      lectureId.hashCode ^
      userId.hashCode ^
      clicked.hashCode;
  }
}

final flashCardsLearningStateControllerProvider = StateNotifierProvider<
    FlashCardsLearningStateController, FlashcardLearningState>((ref) {
  return FlashCardsLearningStateController(ref: ref);
});

class FlashCardsLearningStateController
    extends StateNotifier<FlashcardLearningState> {
  final Ref _ref;
  FlashCardsLearningStateController({
    required Ref ref,
  })  : _ref = ref,
        super(FlashcardLearningState(
          currentIndex: 0,
          id: '',
          flashCards: [],
          courseId: '',
          lectureId: '',
          userId: '',
          clicked: false,
        ));

  void nextCard() {
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void startLearning({
    required String courseId,
    required String lectureId,
    required String userId,
    required List<FlashCardModel> flashCards,
  }) {
    final id = const Uuid().v4();
    state = state.copyWith(
      id: id,
      currentIndex: 0,
      courseId: courseId,
      lectureId: lectureId,
      userId: userId,
      flashCards: flashCards,
    );
    _ref.read(goRouterProvider).goNamed("Flashcards session", pathParameters: {
      "sessionId": id,
    });
  }

  void changeFlashCardStatus(
      {required FlashCardModel flashcard, required FlashCardStatus status}) {
    final newFlashCard = flashcard.copyWith(status: status);
    final newFlashCards = state.flashCards.map((e) {
      if (e.id == flashcard.id) {
        return newFlashCard;
      }
      return e;
    }).toList();
    state = state.copyWith(flashCards: newFlashCards);
    _ref.read(flashCardsRepositoryProvider).changeFlashCardStatus(
          courseId: state.courseId,
          lectureId: state.lectureId,
          flashCardModel: newFlashCard,
          userId: state.userId,
        );
    if (state.currentIndex < state.flashCards.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1, clicked: false);

    } else {
      _ref.invalidate(lectureProvider(GetLectureParams(
          courseId: state.courseId, lectureId: state.lectureId)));
      _ref.read(goRouterProvider).goNamed('lecture screen', pathParameters: {
        "courseId": state.courseId,
        "lectureId": state.lectureId,
      });
    }
  }

  void show(){
    print("click");
    state = state.copyWith(clicked: true);
  }

  void reset() {
    state = FlashcardLearningState(
      currentIndex: 0,
      id: '',
      flashCards: [],
      courseId: '',
      lectureId: '',
      userId: '',
      clicked: false,
    );
  }
}
