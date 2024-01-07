import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends EntityFormValues<String> {
  final String? name;
  final String? description;
  final DateTime? createDate;

  final User? leader;
  final Classroom? classroom;

  Group(
      {super.id,
      this.name,
      this.description,
      this.createDate,
      this.leader,
      this.classroom});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
