import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:flutter_hutech_classroom/models/post.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends EntityFormValues<String> {
  final String? content;
  final DateTime? createDate;

  String? userId;
  final User? user;
  String? postId;
  final Post? post;

  Comment({
    super.id,
    this.content,
    this.createDate,
    this.user,
    this.post,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
