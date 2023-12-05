import 'package:flutter_hutech_classroom/enums/semester.dart';

extension SemesterExtensinos on Semester {
  String toText() {
    switch (this) {
      case Semester.i:
        return 'I';
      case Semester.ii:
        return 'II';
      case Semester.iii:
        return 'III';
    }
  }
}
