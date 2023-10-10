import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? id;
  final String? userName;
  final String? firstName;
  final String? lastName;
  // final Faculty faculty;
  final String? token = "";
  User({this.id, this.userName, this.firstName, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
