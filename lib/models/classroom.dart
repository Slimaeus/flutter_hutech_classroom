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
  final String? studyGroup;
  final String? practicalStudyGroup;
  final User? lecturer;

  Classroom(
      {this.id,
      this.title,
      this.description,
      this.room,
      this.studyPeriod,
      this.className,
      this.schoolYear,
      this.studyGroup,
      this.practicalStudyGroup,
      this.lecturer});

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);

  Map<String, dynamic> toJson() => _$ClassroomToJson(this);
}
