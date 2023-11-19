// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScoreStore on ScoreStoreBase, Store {
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

  @override
  String toString() {
    return '''
scoreTypes: ${scoreTypes}
    ''';
  }
}
