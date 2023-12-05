import 'package:flutter_hutech_classroom/enums/semester.dart';
import 'package:flutter_hutech_classroom/models/subject.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classroom.g.dart';

@JsonSerializable()
class Classroom {
  final String? id;
  final String? title;
  final String? description;
  final String? room;
  final String? studyPeriod;
  @JsonKey(name: 'class')
  final String? className;
  final String? schoolYear;
  final Semester? semester;
  final String? studyGroup;
  final String? practicalStudyGroup;
  final User? lecturer;
  final Subject? subject;

  Classroom(
      {this.id,
      this.title,
      this.description,
      this.room,
      this.studyPeriod,
      this.className,
      this.schoolYear,
      this.semester,
      this.studyGroup,
      this.practicalStudyGroup,
      this.lecturer,
      this.subject});

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomToJson(this);
}
