// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResultStore on ResultStoreBase, Store {
  late final _$isFetchingResultsAtom =
      Atom(name: 'ResultStoreBase.isFetchingResults', context: context);

  @override
  bool get isFetchingResults {
    _$isFetchingResultsAtom.reportRead();
    return super.isFetchingResults;
  }

  @override
  set isFetchingResults(bool value) {
    _$isFetchingResultsAtom.reportWrite(value, super.isFetchingResults, () {
      super.isFetchingResults = value;
    });
  }

  late final _$resultImageAtom =
      Atom(name: 'ResultStoreBase.resultImage', context: context);

  @override
  File? get resultImage {
    _$resultImageAtom.reportRead();
    return super.resultImage;
  }

  @override
  set resultImage(File? value) {
    _$resultImageAtom.reportWrite(value, super.resultImage, () {
      super.resultImage = value;
    });
  }

  late final _$scannedTranscriptAtom =
      Atom(name: 'ResultStoreBase.scannedTranscript', context: context);

  @override
  ObservableList<StudentResult> get scannedTranscript {
    _$scannedTranscriptAtom.reportRead();
    return super.scannedTranscript;
  }

  @override
  set scannedTranscript(ObservableList<StudentResult> value) {
    _$scannedTranscriptAtom.reportWrite(value, super.scannedTranscript, () {
      super.scannedTranscript = value;
    });
  }

  late final _$fetchScannedTranscriptAsyncAction =
      AsyncAction('ResultStoreBase.fetchScannedTranscript', context: context);

  @override
  Future<bool> fetchScannedTranscript() {
    return _$fetchScannedTranscriptAsyncAction
        .run(() => super.fetchScannedTranscript());
  }

  late final _$ResultStoreBaseActionController =
      ActionController(name: 'ResultStoreBase', context: context);

  @override
  void setImage(File image) {
    final _$actionInfo = _$ResultStoreBaseActionController.startAction(
        name: 'ResultStoreBase.setImage');
    try {
      return super.setImage(image);
    } finally {
      _$ResultStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFetchingResults: ${isFetchingResults},
resultImage: ${resultImage},
scannedTranscript: ${scannedTranscript}
    ''';
  }
}
