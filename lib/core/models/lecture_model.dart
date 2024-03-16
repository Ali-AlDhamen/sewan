// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/question.dart';

class LectureModel {
  final String title;
  final String id;
  final List<FlashCardModel> flashCards;
  final String courseId;
  final String userId;
  final List<Question> questions;
  LectureModel({
    required this.title,
    required this.id,
    required this.flashCards,
    required this.courseId,
    required this.userId,
    required this.questions,
  });

  LectureModel copyWith({
    String? title,
    String? id,
    List<FlashCardModel>? flashCards,
    String? courseId,
    String? userId,
    List<Question>? questions,
  }) {
    return LectureModel(
      title: title ?? this.title,
      id: id ?? this.id,
      flashCards: flashCards ?? this.flashCards,
      courseId: courseId ?? this.courseId,
      userId: userId ?? this.userId,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'flashCards': flashCards.map((x) => x.toMap()).toList(),
      'courseId': courseId,
      'userId': userId,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory LectureModel.fromMap(Map<String, dynamic> map) {
    return LectureModel(
      title: map['title'] as String,
      id: map['id'] as String,
      flashCards: List<FlashCardModel>.from((map['flashCards'] as List<dynamic>).map<FlashCardModel>((x) => FlashCardModel.fromMap(x as Map<String,dynamic>),),),
      courseId: map['courseId'] as String,
      userId: map['userId'] as String,
      questions: List<Question>.from((map['questions'] as List<dynamic>).map<Question>((x) => Question.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory LectureModel.fromJson(String source) => LectureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LectureModel(title: $title, id: $id, flashCards: $flashCards, courseId: $courseId, userId: $userId, questions: $questions)';
  }

  @override
  bool operator ==(covariant LectureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.id == id &&
      listEquals(other.flashCards, flashCards) &&
      other.courseId == courseId &&
      other.userId == userId &&
      listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return title.hashCode ^
      id.hashCode ^
      flashCards.hashCode ^
      courseId.hashCode ^
      userId.hashCode ^
      questions.hashCode;
  }
}
