import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends EntityFormValues<String> {
  final String? content;
  final String? link;
  final DateTime? createDate;

  final User? user;
  final Classroom? classroom;

  Post(
      {super.id,
      this.content,
      this.link,
      this.createDate,
      this.user,
      this.classroom});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
