// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScoreStore on ScoreStoreBase, Store {
  late final _$isFetchingScoreAtom =
      Atom(name: 'ScoreStoreBase.isFetchingScore', context: context);

  @override
  bool get isFetchingScore {
    _$isFetchingScoreAtom.reportRead();
    return super.isFetchingScore;
  }

  @override
  set isFetchingScore(bool value) {
    _$isFetchingScoreAtom.reportWrite(value, super.isFetchingScore, () {
      super.isFetchingScore = value;
    });
  }

  late final _$scoreExcelFileAtom =
      Atom(name: 'ScoreStoreBase.scoreExcelFile', context: context);

  @override
  File? get scoreExcelFile {
    _$scoreExcelFileAtom.reportRead();
    return super.scoreExcelFile;
  }

  @override
  set scoreExcelFile(File? value) {
    _$scoreExcelFileAtom.reportWrite(value, super.scoreExcelFile, () {
      super.scoreExcelFile = value;
    });
  }

  late final _$scoreTypesAtom =
      Atom(name: 'ScoreStoreBase.scoreTypes', context: context);

  @override
  ObservableList<ScoreType> get scoreTypes {
    _$scoreTypesAtom.reportRead();
    return super.scoreTypes;
  }

  @override
  set scoreTypes(ObservableList<ScoreType> value) {
    _$scoreTypesAtom.reportWrite(value, super.scoreTypes, () {
      super.scoreTypes = value;
    });
  }

  late final _$importScoreExcelAsyncAction =
      AsyncAction('ScoreStoreBase.importScoreExcel', context: context);

  @override
  Future<bool> importScoreExcel(String classroomId, int scoreTypeId) {
    return _$importScoreExcelAsyncAction
        .run(() => super.importScoreExcel(classroomId, scoreTypeId));
  }

  late final _$ScoreStoreBaseActionController =
      ActionController(name: 'ScoreStoreBase', context: context);

  @override
  void setScoreExcelFile(File file) {
    final _$actionInfo = _$ScoreStoreBaseActionController.startAction(
        name: 'ScoreStoreBase.setScoreExcelFile');
    try {
      return super.setScoreExcelFile(file);
    } finally {
      _$ScoreStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFetchingScore: ${isFetchingScore},
scoreExcelFile: ${scoreExcelFile},
scoreTypes: ${scoreTypes}
    ''';
  }
}
