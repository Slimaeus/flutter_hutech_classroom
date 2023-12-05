import 'package:json_annotation/json_annotation.dart';

enum Semester {
  @JsonValue('I')
  i,
  @JsonValue('II')
  ii,
  @JsonValue('III')
  iii
}
