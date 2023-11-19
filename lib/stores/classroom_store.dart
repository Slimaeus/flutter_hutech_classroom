import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:provider/provider.dart';

part 'classroom_store.g.dart';

class ClassroomStore = ClassroomStoreBase with _$ClassroomStore;

abstract class ClassroomStoreBase extends BaseStore with Store, BaseStoreMixin {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore _commonStore;

  @observable
  bool isFetchingClassroom = false;

  @observable
  ObservableList<Classroom> classrooms = ObservableList();

  Future<bool> fetchClassrooms() async {
    isFetchingClassroom = true;
    var response =
        await _apiService.get<List<Classroom>>('v1/Classrooms', (results) {
      return (results as List).map((c) => Classroom.fromJson(c)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      classrooms = ObservableList.of(response.data!);
      isFetchingClassroom = false;
      return true;
    }
    isFetchingClassroom = false;
    return false;
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }
}
