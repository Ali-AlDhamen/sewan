// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sewan/core/models/lecture_model.dart';

class CourseModel {
  String id;
  String name;
  String userId;
  List<LectureModel> lectures;
  CourseModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.lectures,
  });

  CourseModel copyWith({
    String? id,
    String? name,
    String? userId,
    List<LectureModel>? lectures,
  }) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      lectures: lectures ?? this.lectures,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'lectures': lectures.map((x) => x.toMap()).toList(),
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      lectures: List<LectureModel>.from((map['lectures'] as List<dynamic>).map<LectureModel>((x) => LectureModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) => CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(id: $id, name: $name, userId: $userId, lectures: $lectures)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.userId == userId &&
      listEquals(other.lectures, lectures);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      userId.hashCode ^
      lectures.hashCode;
  }
  }
