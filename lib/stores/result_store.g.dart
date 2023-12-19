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

  late final _$croppedImageAtom =
      Atom(name: 'ResultStoreBase.croppedImage', context: context);

  @override
  File? get croppedImage {
    _$croppedImageAtom.reportRead();
    return super.croppedImage;
  }

  @override
  set croppedImage(File? value) {
    _$croppedImageAtom.reportWrite(value, super.croppedImage, () {
      super.croppedImage = value;
    });
  }

  late final _$croppedImagesAtom =
      Atom(name: 'ResultStoreBase.croppedImages', context: context);

  @override
  ObservableList<File> get croppedImages {
    _$croppedImagesAtom.reportRead();
    return super.croppedImages;
  }

  @override
  set croppedImages(ObservableList<File> value) {
    _$croppedImagesAtom.reportWrite(value, super.croppedImages, () {
      super.croppedImages = value;
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

  late final _$multipleFileScannedTranscriptAtom = Atom(
      name: 'ResultStoreBase.multipleFileScannedTranscript', context: context);

  @override
  ObservableList<StudentResult> get multipleFileScannedTranscript {
    _$multipleFileScannedTranscriptAtom.reportRead();
    return super.multipleFileScannedTranscript;
  }

  @override
  set multipleFileScannedTranscript(ObservableList<StudentResult> value) {
    _$multipleFileScannedTranscriptAtom
        .reportWrite(value, super.multipleFileScannedTranscript, () {
      super.multipleFileScannedTranscript = value;
    });
  }

  late final _$multipleScannedTranscriptAtom =
      Atom(name: 'ResultStoreBase.multipleScannedTranscript', context: context);

  @override
  ObservableList<List<StudentResult>> get multipleScannedTranscript {
    _$multipleScannedTranscriptAtom.reportRead();
    return super.multipleScannedTranscript;
  }

  @override
  set multipleScannedTranscript(ObservableList<List<StudentResult>> value) {
    _$multipleScannedTranscriptAtom
        .reportWrite(value, super.multipleScannedTranscript, () {
      super.multipleScannedTranscript = value;
    });
  }

  late final _$fetchScannedTranscriptAsyncAction =
      AsyncAction('ResultStoreBase.fetchScannedTranscript', context: context);

  @override
  Future<bool> fetchScannedTranscript() {
    return _$fetchScannedTranscriptAsyncAction
        .run(() => super.fetchScannedTranscript());
  }

  late final _$fetchMultipleFileScannedTranscriptAsyncAction = AsyncAction(
      'ResultStoreBase.fetchMultipleFileScannedTranscript',
      context: context);

  @override
  Future<bool> fetchMultipleFileScannedTranscript() {
    return _$fetchMultipleFileScannedTranscriptAsyncAction
        .run(() => super.fetchMultipleFileScannedTranscript());
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
  void setCroppedImage(File image) {
    final _$actionInfo = _$ResultStoreBaseActionController.startAction(
        name: 'ResultStoreBase.setCroppedImage');
    try {
      return super.setCroppedImage(image);
    } finally {
      _$ResultStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMultipleScannedTranscript(List<List<StudentResult>> lists) {
    final _$actionInfo = _$ResultStoreBaseActionController.startAction(
        name: 'ResultStoreBase.setMultipleScannedTranscript');
    try {
      return super.setMultipleScannedTranscript(lists);
    } finally {
      _$ResultStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScannedTranscript(List<StudentResult> list) {
    final _$actionInfo = _$ResultStoreBaseActionController.startAction(
        name: 'ResultStoreBase.setScannedTranscript');
    try {
      return super.setScannedTranscript(list);
    } finally {
      _$ResultStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMultipleFileScannedTranscript(List<StudentResult> list) {
    final _$actionInfo = _$ResultStoreBaseActionController.startAction(
        name: 'ResultStoreBase.setMultipleFileScannedTranscript');
    try {
      return super.setMultipleFileScannedTranscript(list);
    } finally {
      _$ResultStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFetchingResults: ${isFetchingResults},
resultImage: ${resultImage},
croppedImage: ${croppedImage},
croppedImages: ${croppedImages},
scannedTranscript: ${scannedTranscript},
multipleFileScannedTranscript: ${multipleFileScannedTranscript},
multipleScannedTranscript: ${multipleScannedTranscript}
    ''';
  }
}
