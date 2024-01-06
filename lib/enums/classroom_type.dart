import 'package:json_annotation/json_annotation.dart';

enum ClassroomType {
  @JsonValue('TheoryRoom')
  theoryRoom,
  @JsonValue('PracticeRoom')
  practiceRoom,
}
