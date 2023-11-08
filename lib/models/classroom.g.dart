// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classroom _$ClassroomFromJson(Map<String, dynamic> json) => Classroom(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      room: json['room'] as String?,
      studyPeriod: json['studyPeriod'] as String?,
      className: json['class'] as String?,
      schoolYear: json['schoolYear'] as String?,
      schoolGroup: json['schoolGroup'] as String?,
      practicalStudyGroup: json['practicalStudyGroup'] as String?,
      lecturer: json['lecturer'] == null
          ? null
          : User.fromJson(json['lecturer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassroomToJson(Classroom instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'room': instance.room,
      'studyPeriod': instance.studyPeriod,
      'class': instance.className,
      'schoolYear': instance.schoolYear,
      'schoolGroup': instance.schoolGroup,
      'practicalStudyGroup': instance.practicalStudyGroup,
      'lecturer': instance.lecturer,
    };
