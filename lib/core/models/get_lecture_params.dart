// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class GetLectureParams {
  final String courseId;
  final String lectureId;
  GetLectureParams({
    required this.courseId,
    required this.lectureId,
  });


  GetLectureParams copyWith({
    String? courseId,
    String? lectureId,
  }) {
    return GetLectureParams(
      courseId: courseId ?? this.courseId,
      lectureId: lectureId ?? this.lectureId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseId': courseId,
      'lectureId': lectureId,
    };
  }

  factory GetLectureParams.fromMap(Map<String, dynamic> map) {
    return GetLectureParams(
      courseId: map['courseId'] as String,
      lectureId: map['lectureId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetLectureParams.fromJson(String source) => GetLectureParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetLectureParams(courseId: $courseId, lectureId: $lectureId)';

  @override
  bool operator ==(covariant GetLectureParams other) {
    if (identical(this, other)) return true;
  
    return 
      other.courseId == courseId &&
      other.lectureId == lectureId;
  }

  @override
  int get hashCode => courseId.hashCode ^ lectureId.hashCode;
}
