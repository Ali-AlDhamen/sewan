// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  String id;
  String question;
  String answer;
  List<String> choices;
  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.choices,
  });

  Question copyWith({
    String? id,
    String? question,
    String? answer,
    List<String>? choices,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      choices: choices ?? this.choices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
      'choices': choices,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      question: map['question'] as String,
      answer: map['answer'] as String,
      choices: List<String>.from(map['choices']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answer: $answer, choices: $choices)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        other.answer == answer &&
        listEquals(other.choices, choices);
  }

  @override
  int get hashCode {
    return id.hashCode ^ question.hashCode ^ answer.hashCode ^ choices.hashCode;
  }
}
