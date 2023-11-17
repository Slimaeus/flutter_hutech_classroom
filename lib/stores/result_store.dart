import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
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
  ObservableList<StudentResult> results = ObservableList();

  @action
  void setImage(File image) {
    resultImage = image;
  }

  @action
  Future<bool> getResults() async {
    isFetchingResults = true;
    var response = await _apiService.uploadFile<List<StudentResult>>(
        'v1/Features/vision/test',
        {'type': 'image/jpg'},
        'file',
        resultImage!.path,
        resultImage!, (results) {
      return (results as List).map((r) => StudentResult.fromJson(r)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      results = ObservableList.of(response.data!);
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
