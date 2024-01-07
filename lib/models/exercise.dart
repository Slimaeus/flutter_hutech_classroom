import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise extends EntityFormValues<String> {
  final String? title;
  final String? instruction;
  final String? link;
  final double? totalScore;
  final DateTime? deadline;
  final String? topic;
  final String? criteria;
  final DateTime? createDate;

  final Classroom? classroom;

  Exercise(
      {super.id,
      this.title,
      this.instruction,
      this.link,
      this.totalScore,
      this.deadline,
      this.topic,
      this.criteria,
      this.createDate,
      this.classroom});

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
