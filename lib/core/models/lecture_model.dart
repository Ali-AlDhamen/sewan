import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sewan/core/models/flashcard_model.dart';


class LectureModel {
  final String title;
  final String id;
  final List<FlashCardModel> flashCards;
  LectureModel({
    required this.title,
    required this.id,
    required this.flashCards,
  });

  

  LectureModel copyWith({
    String? title,
    String? id,
    List<FlashCardModel>? flashCards,
  }) {
    return LectureModel(
      title: title ?? this.title,
      id: id ?? this.id,
      flashCards: flashCards ?? this.flashCards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'flashCards': flashCards.map((x) => x.toMap()).toList(),
    };
  }

  factory LectureModel.fromMap(Map<String, dynamic> map) {
    return LectureModel(
      title: map['title'] as String,
      id: map['id'] as String,
      flashCards: List<FlashCardModel>.from((map['flashCards'] as List<int>).map<FlashCardModel>((x) => FlashCardModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory LectureModel.fromJson(String source) => LectureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LectureModel(title: $title, id: $id, flashCards: $flashCards)';

  @override
  bool operator ==(covariant LectureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.id == id &&
      listEquals(other.flashCards, flashCards);
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode ^ flashCards.hashCode;
}
