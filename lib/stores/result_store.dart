import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
  File? croppedImage;

  @observable
  ObservableList<File> croppedImages = ObservableList.of([]);

  @observable
  ObservableList<StudentResult> scannedTranscript = ObservableList();

  @observable
  ObservableList<List<StudentResult>> multipleScannedTranscript =
      ObservableList();

  @action
  void setImage(File image) {
    resultImage = image;
  }

  @action
  void setCroppedImage(File image) {
    croppedImage = null;
    croppedImage = image;
    croppedImages.add(image);
  }

  @action
  void setMultipleScannedTranscript(List<List<StudentResult>> lists) {
    multipleScannedTranscript = ObservableList.of(lists);
  }

  @action
  void setScannedTranscript(List<StudentResult> list) {
    scannedTranscript = ObservableList.of(list);
  }

  @action
  Future<bool> fetchScannedTranscript() async {
    bool isTest = !isFetchingResults;
    if (isTest) {
      scannedTranscript = ObservableList<StudentResult>.of([
        StudentResult(
            ordinalNumber: 1,
            score: 9.5,
            student: User(
                id: '1',
                userName: '2080600914',
                firstName: 'Thái',
                lastName: 'Nguyễn Hồng'),
            classroom: Classroom(className: '20DTHD3')),
        StudentResult(
            ordinalNumber: 2,
            score: 10,
            student: User(
                id: '2',
                userName: '2080600803',
                firstName: 'Vân',
                lastName: 'Trương Thục'),
            classroom: Classroom(className: '20DTHD3')),
      ]);
      return true;
    }
    if (croppedImage == null) return false;
    isFetchingResults = true;
    var response = await _apiService.uploadFile<List<StudentResult>>(
        'v1/Scores/ScanResult',
        {'type': 'image/jpg'},
        'file',
        croppedImage!.path,
        croppedImage!, (results) {
      return (results as List).map((r) => StudentResult.fromJson(r)).toList();
    }, headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      scannedTranscript = ObservableList.of(response.data!);
      isFetchingResults = false;
      await croppedImage!.delete();
      croppedImage = null;
      resultImage = null;
      return true;
    }
    isFetchingResults = false;
    await croppedImage!.delete();
    return false;
  }

  Future<bool> fetchMultipleScannedTranscript() async {
    bool isTest = !isFetchingResults;
    if (isTest) {
      multipleScannedTranscript = ObservableList<List<StudentResult>>.of(
        [
          [
            StudentResult(
                ordinalNumber: 1,
                score: 9.5,
                student: User(
                    id: '1',
                    userName: '2080600914',
                    firstName: 'Thái',
                    lastName: 'Nguyễn Hồng'),
                classroom: Classroom(className: '20DTHD3')),
            StudentResult(
                ordinalNumber: 2,
                score: 10,
                student: User(
                    id: '2',
                    userName: '2080600803',
                    firstName: 'Vân',
                    lastName: 'Trương Thục'),
                classroom: Classroom(className: '20DTHD3')),
          ],
          [
            StudentResult(
                ordinalNumber: 1,
                score: 9.5,
                student: User(
                    id: '1',
                    userName: '2080600914',
                    firstName: 'Thái',
                    lastName: 'Nguyễn Hồng'),
                classroom: Classroom(className: '20DTHD3')),
            StudentResult(
                ordinalNumber: 2,
                score: 10,
                student: User(
                    id: '2',
                    userName: '2080600803',
                    firstName: 'Vân',
                    lastName: 'Trương Thục'),
                classroom: Classroom(className: '20DTHD3')),
          ]
        ],
      );
      return true;
    }
    if (croppedImages.isEmpty) return false;
    var url = Uri.parse(
        "https://hutechclassroom.azurewebsites.net/api/v1/Scores/ScanMultipleResult");

    var request = http.MultipartRequest('POST', url);
    var fileModels = croppedImages;
    for (var i = 0; i < fileModels.length; i++) {
      var fileModel = fileModels[i];
      var file = await http.MultipartFile.fromPath(
        'files', // field name
        fileModel.path, // file path
        filename: path.basename(fileModel.path), // file name
      );
      request.files.add(file);
      request.headers.addAll({'Authorization': 'Bearer ${_commonStore.jwt}'});
      // request.fields['fileModels[$i].classroomId'] =
      //     fileModel.classroomId;
    }
    isFetchingResults = true;
    var response = await request.send();
    if (response.statusCode < 400) {
      var body = await response.stream.bytesToString();
      final dynamic jsonResponse = body.isNotEmpty ? json.decode(body) : {};
      var lists = List<dynamic>.from(jsonResponse);
      var studentResultLists = lists
          .map((list) =>
              (list as List).map((c) => StudentResult.fromJson(c)).toList())
          .toList();
      setMultipleScannedTranscript(studentResultLists);
      isFetchingResults = false;
      return true;
    } else {
      isFetchingResults = false;
      return false;
    }
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }

  @override
  void resetValue() {
    croppedImage = null;
    croppedImages = ObservableList();
    resultImage = null;
    scannedTranscript = ObservableList();
    multipleScannedTranscript = ObservableList();
  }

  @override
  void onDispose(BuildContext context) {
    // scannedTranscript = ObservableList();
    // if (croppedImage != null) {
    //   croppedImage!.deleteSync();
    // }
    croppedImage = null;
    resultImage = null;
    super.onDispose(context);
  }
}
