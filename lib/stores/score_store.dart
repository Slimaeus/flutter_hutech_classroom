import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/score_type.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'score_store.g.dart';

class ScoreStore = ScoreStoreBase with _$ScoreStore;

abstract class ScoreStoreBase extends BaseStore with Store, BaseStoreMixin {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore _commonStore;

  @observable
  ObservableList<ScoreType> scoreTypes = ObservableList();

  Future<bool> fetchScoreTypes() async {
    var response =
        await _apiService.get<List<ScoreType>>('v1/ScoreTypes', (results) {
      return (results as List).map((c) => ScoreType.fromJson(c)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      scoreTypes = ObservableList.of(response.data!);
      return true;
    }
    return false;
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }
}
