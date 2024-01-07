// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClassroomStore on ClassroomStoreBase, Store {
  late final _$isFetchingClassroomAtom =
      Atom(name: 'ClassroomStoreBase.isFetchingClassroom', context: context);

  @override
  bool get isFetchingClassroom {
    _$isFetchingClassroomAtom.reportRead();
    return super.isFetchingClassroom;
  }

  @override
  set isFetchingClassroom(bool value) {
    _$isFetchingClassroomAtom.reportWrite(value, super.isFetchingClassroom, () {
      super.isFetchingClassroom = value;
    });
  }

  late final _$classroomsAtom =
      Atom(name: 'ClassroomStoreBase.classrooms', context: context);

  @override
  ObservableList<Classroom> get classrooms {
    _$classroomsAtom.reportRead();
    return super.classrooms;
  }

  @override
  set classrooms(ObservableList<Classroom> value) {
    _$classroomsAtom.reportWrite(value, super.classrooms, () {
      super.classrooms = value;
    });
  }

  late final _$selectedClassroomAtom =
      Atom(name: 'ClassroomStoreBase.selectedClassroom', context: context);

  @override
  Classroom get selectedClassroom {
    _$selectedClassroomAtom.reportRead();
    return super.selectedClassroom;
  }

  @override
  set selectedClassroom(Classroom value) {
    _$selectedClassroomAtom.reportWrite(value, super.selectedClassroom, () {
      super.selectedClassroom = value;
    });
  }

  late final _$transcriptAtom =
      Atom(name: 'ClassroomStoreBase.transcript', context: context);

  @override
  ObservableList<StudentResult> get transcript {
    _$transcriptAtom.reportRead();
    return super.transcript;
  }

  @override
  set transcript(ObservableList<StudentResult> value) {
    _$transcriptAtom.reportWrite(value, super.transcript, () {
      super.transcript = value;
    });
  }

  late final _$classroomUsersAtom =
      Atom(name: 'ClassroomStoreBase.classroomUsers', context: context);

  @override
  ObservableList<User> get classroomUsers {
    _$classroomUsersAtom.reportRead();
    return super.classroomUsers;
  }

  @override
  set classroomUsers(ObservableList<User> value) {
    _$classroomUsersAtom.reportWrite(value, super.classroomUsers, () {
      super.classroomUsers = value;
    });
  }

  late final _$isClassroomUsersFetchingAtom = Atom(
      name: 'ClassroomStoreBase.isClassroomUsersFetching', context: context);

  @override
  bool get isClassroomUsersFetching {
    _$isClassroomUsersFetchingAtom.reportRead();
    return super.isClassroomUsersFetching;
  }

  @override
  set isClassroomUsersFetching(bool value) {
    _$isClassroomUsersFetchingAtom
        .reportWrite(value, super.isClassroomUsersFetching, () {
      super.isClassroomUsersFetching = value;
    });
  }

  late final _$ClassroomStoreBaseActionController =
      ActionController(name: 'ClassroomStoreBase', context: context);

  @override
  void setClassroom(Classroom classroom) {
    final _$actionInfo = _$ClassroomStoreBaseActionController.startAction(
        name: 'ClassroomStoreBase.setClassroom');
    try {
      return super.setClassroom(classroom);
    } finally {
      _$ClassroomStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFetchingClassroom: ${isFetchingClassroom},
classrooms: ${classrooms},
selectedClassroom: ${selectedClassroom},
transcript: ${transcript},
classroomUsers: ${classroomUsers},
isClassroomUsersFetching: ${isClassroomUsersFetching}
    ''';
  }
}
