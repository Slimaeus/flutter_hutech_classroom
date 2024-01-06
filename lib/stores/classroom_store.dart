import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
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

  @observable
  Classroom selectedClassroom = Classroom();

  @observable
  ObservableList<StudentResult> transcript = ObservableList();

  @action
  void setClassroom(Classroom classroom) {
    selectedClassroom = classroom;
  }

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

  Future<bool> fetchClassroom(String classroomId) async {
    isFetchingClassroom = true;
    var response = await _apiService
        .get<Classroom>('v1/Classrooms/$classroomId', (results) {
      return Classroom.fromJson(results);
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setClassroom(response.data!);
      isFetchingClassroom = false;
      return true;
    }
    isFetchingClassroom = false;
    return false;
  }

  Future<bool> fetchTranscript(String classroomId) async {
    var response = await _apiService.get<List<StudentResult>>(
        'v1/Classrooms/$classroomId/results', (results) {
      return (results as List).map((r) => StudentResult.fromJson(r)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      transcript = ObservableList.of(response.data!);
      return true;
    }
    return false;
  }

  Future<bool> fetchTranscriptWithScoreType(
      String classroomId, int scoreType) async {
    var response = await _apiService.get<List<StudentResult>>(
        'v1/Classrooms/$classroomId/results/$scoreType', (results) {
      return (results as List).map((r) => StudentResult.fromJson(r)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      transcript = ObservableList.of(response.data!);
      return true;
    }
    return false;
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }

  @override
  void onDispose(BuildContext context) {
    transcript = ObservableList();
    super.onDispose(context);
  }
}
