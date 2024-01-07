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
      semester: $enumDecodeNullable(_$SemesterEnumMap, json['semester']),
      studyGroup: json['studyGroup'] as String?,
      practicalStudyGroup: json['practicalStudyGroup'] as String?,
      lecturer: json['lecturer'] == null
          ? null
          : User.fromJson(json['lecturer'] as Map<String, dynamic>),
      subject: json['subject'] == null
          ? null
          : Subject.fromJson(json['subject'] as Map<String, dynamic>),
      faculty: json['faculty'] == null
          ? null
          : Faculty.fromJson(json['faculty'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$ClassroomTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ClassroomToJson(Classroom instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'room': instance.room,
      'studyPeriod': instance.studyPeriod,
      'class': instance.className,
      'schoolYear': instance.schoolYear,
      'semester': _$SemesterEnumMap[instance.semester],
      'studyGroup': instance.studyGroup,
      'practicalStudyGroup': instance.practicalStudyGroup,
      'lecturer': instance.lecturer,
      'subject': instance.subject,
      'faculty': instance.faculty,
      'type': _$ClassroomTypeEnumMap[instance.type],
    };

const _$SemesterEnumMap = {
  Semester.i: 'I',
  Semester.ii: 'II',
  Semester.iii: 'III',
};

const _$ClassroomTypeEnumMap = {
  ClassroomType.theoryRoom: 'TheoryRoom',
  ClassroomType.practiceRoom: 'PracticeRoom',
};
