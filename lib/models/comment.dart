import 'package:flutter_hutech_classroom/models/post.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String? id;
  final String? content;
  final DateTime? createDate;

  final User? user;
  final Post? post;

  Comment({this.id, this.content, this.createDate, this.user, this.post});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
