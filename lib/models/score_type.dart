import 'package:json_annotation/json_annotation.dart';

part 'score_type.g.dart';

@JsonSerializable()
class ScoreType {
  final int? id;
  final String? name;

  ScoreType({
    this.id,
    this.name,
  });

  factory ScoreType.fromJson(Map<String, dynamic> json) =>
      _$ScoreTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreTypeToJson(this);
}
