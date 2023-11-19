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

  @override
  String toString() {
    return '''
isFetchingClassroom: ${isFetchingClassroom},
classrooms: ${classrooms}
    ''';
  }
}
