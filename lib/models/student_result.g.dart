// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentResult _$StudentResultFromJson(Map<String, dynamic> json) =>
    StudentResult(
      ordinalNumber: json['ordinalNumber'] as int?,
      score: (json['score'] as num?)?.toDouble(),
      student: json['student'] == null
          ? null
          : User.fromJson(json['student'] as Map<String, dynamic>),
      classroom: json['classroom'] == null
          ? null
          : Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
      scoreType: json['scoreType'] == null
          ? null
          : ScoreType.fromJson(json['scoreType'] as Map<String, dynamic>),
      studentId: json['studentId'] as String?,
      comparedScore: (json['comparedScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StudentResultToJson(StudentResult instance) =>
    <String, dynamic>{
      'ordinalNumber': instance.ordinalNumber,
      'score': instance.score,
      'student': instance.student,
      'classroom': instance.classroom,
      'scoreType': instance.scoreType,
      'studentId': instance.studentId,
      'comparedScore': instance.comparedScore,
    };
