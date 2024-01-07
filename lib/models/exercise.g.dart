// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as String?,
      title: json['title'] as String?,
      instruction: json['instruction'] as String?,
      link: json['link'] as String?,
      totalScore: (json['totalScore'] as num?)?.toDouble(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      topic: json['topic'] as String?,
      criteria: json['criteria'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      classroom: json['classroom'] == null
          ? null
          : Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'instruction': instance.instruction,
      'link': instance.link,
      'totalScore': instance.totalScore,
      'deadline': instance.deadline?.toIso8601String(),
      'topic': instance.topic,
      'criteria': instance.criteria,
      'createDate': instance.createDate?.toIso8601String(),
      'classroom': instance.classroom,
    };
