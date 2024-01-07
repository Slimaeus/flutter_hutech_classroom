import 'package:flutter_hutech_classroom/models/faculty.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? id;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Faculty? faculty;
  @JsonKey(name: 'class')
  final String? className;
  final String? token;
  final List<String> roles;

  User(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.faculty,
      this.token,
      this.className,
      this.roles = const []});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
