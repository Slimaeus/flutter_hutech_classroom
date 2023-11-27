import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'result_store.g.dart';

class ResultStore = ResultStoreBase with _$ResultStore;

abstract class ResultStoreBase extends BaseStore with Store, BaseStoreMixin {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore _commonStore;

  @observable
  bool isFetchingResults = false;

  @observable
  File? resultImage;

  @observable
  ObservableList<StudentResult> scannedTranscript = ObservableList();

  @action
  void setImage(File image) {
    resultImage = image;
  }

  @action
  Future<bool> fetchScannedTranscript() async {
    // scannedTranscript = ObservableList<StudentResult>.of([
    //   StudentResult(
    //       ordinalNumber: 1,
    //       score: 9.5,
    //       student: User(
    //           id: '1',
    //           userName: '2080600914',
    //           firstName: 'Thái',
    //           lastName: 'Nguyễn Hồng'),
    //       classroom: Classroom(className: '20DTHD3')),
    //   StudentResult(
    //       ordinalNumber: 2,
    //       score: 10,
    //       student: User(
    //           id: '2',
    //           userName: '2080600803',
    //           firstName: 'Vân',
    //           lastName: 'Trương Thục'),
    //       classroom: Classroom(className: '20DTHD3')),
    // ]);
    // return true;
    isFetchingResults = true;
    var response = await _apiService.uploadFile<List<StudentResult>>(
        'v1/Scores/ScanResult',
        {'type': 'image/jpg'},
        'file',
        resultImage!.path,
        resultImage!, (results) {
      return (results as List).map((r) => StudentResult.fromJson(r)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      scannedTranscript = ObservableList.of(response.data!);
      isFetchingResults = false;
      return true;
    }
    isFetchingResults = false;
    return false;
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }
}