import 'dart:io';

class FileModel {
  String classroomId;
  File file;

  FileModel({required this.classroomId, required this.file});

  Map<String, String> toMap() {
    return {
      'classroomId': classroomId,
    };
  }
}
