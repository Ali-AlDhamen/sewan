// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sewan/core/models/question.dart';

class OnlineQuizSession {
  String id;
  String courseId;
  String lectureId;
  String player1Id;
  String player2Id;
  Map<String, String> player1Answers; 
  Map<String, String> player2Answers; 
  List<Question> questions;
  int currentQuestionIndex;


  OnlineQuizSession({
    required this.id,
    required this.courseId,
    required this.lectureId,
    required this.player1Id,
    required this.player2Id,
    required this.player1Answers,
    required this.player2Answers,
    required this.questions,
    required this.currentQuestionIndex,
  });



  OnlineQuizSession copyWith({
    String? id,
    String? courseId,
    String? lectureId,
    String? player1Id,
    String? player2Id,
    Map<String, String>? player1Answers,
    Map<String, String>? player2Answers,
    List<Question>? questions,
    int? currentQuestionIndex,
  }) {
    return OnlineQuizSession(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      lectureId: lectureId ?? this.lectureId,
      player1Id: player1Id ?? this.player1Id,
      player2Id: player2Id ?? this.player2Id,
      player1Answers: player1Answers ?? this.player1Answers,
      player2Answers: player2Answers ?? this.player2Answers,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'lectureId': lectureId,
      'player1Id': player1Id,
      'player2Id': player2Id,
      'player1Answers': player1Answers,
      'player2Answers': player2Answers,
      'questions': questions.map((x) => x.toMap()).toList(),
      'currentQuestionIndex': currentQuestionIndex,
    };
  }

  factory OnlineQuizSession.fromMap(Map<String, dynamic> map) {
    return OnlineQuizSession(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      lectureId: map['lectureId'] as String,
      player1Id: map['player1Id'] as String,
      player2Id: map['player2Id'] as String,
      player1Answers: Map<String, String>.from((map['player1Answers'] as Map<String, dynamic>)),
      player2Answers: Map<String, String>.from((map['player2Answers'] as Map<String, dynamic>)),
      questions: List<Question>.from((map['questions'] as List<dynamic>).map<Question>((x) => Question.fromMap(x as Map<String,dynamic>),),),
      currentQuestionIndex: map['currentQuestionIndex'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineQuizSession.fromJson(String source) => OnlineQuizSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnlineQuizSession(id: $id, courseId: $courseId, lectureId: $lectureId, player1Id: $player1Id, player2Id: $player2Id, player1Answers: $player1Answers, player2Answers: $player2Answers, questions: $questions, currentQuestionIndex: $currentQuestionIndex)';
  }

  @override
  bool operator ==(covariant OnlineQuizSession other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.courseId == courseId &&
      other.lectureId == lectureId &&
      other.player1Id == player1Id &&
      other.player2Id == player2Id &&
      mapEquals(other.player1Answers, player1Answers) &&
      mapEquals(other.player2Answers, player2Answers) &&
      listEquals(other.questions, questions) &&
      other.currentQuestionIndex == currentQuestionIndex;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      courseId.hashCode ^
      lectureId.hashCode ^
      player1Id.hashCode ^
      player2Id.hashCode ^
      player1Answers.hashCode ^
      player2Answers.hashCode ^
      questions.hashCode ^
      currentQuestionIndex.hashCode;
  }
}
