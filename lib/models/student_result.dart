import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/score_type.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_result.g.dart';

@JsonSerializable()
class StudentResult {
  final int? ordinalNumber;
  final double? score;
  final User? student;
  final Classroom? classroom;
  final ScoreType? scoreType;
  final String? studentId;
  final double? comparedScore;
  StudentResult(
      {this.ordinalNumber,
      this.score,
      this.student,
      this.classroom,
      this.scoreType,
      this.studentId,
      this.comparedScore});

  factory StudentResult.fromJson(Map<String, dynamic> json) =>
      _$StudentResultFromJson(json);

  Map<String, dynamic> toJson() => _$StudentResultToJson(this);
}
