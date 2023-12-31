import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/score_type.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/stores/score_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_dropdown_field.dart';
import 'package:flutter_hutech_classroom/widgets/tables/student_result_table.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key, required this.title});

  final String title;

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  String? selectedYear;

  String? selectedSemester;

  String? selectedCourse;

  String? selectedGroup;

  bool isImport = false;

  Classroom? selectedClassroom;
  ScoreType? selectedScoreType;
  late ResultStore resultStore;
  late ClassroomStore classroomStore;
  late ScoreStore scoreStore;

  late CommonStore commonStore;

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    resultStore.fetchScannedTranscript();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    classroomStore.fetchClassrooms();
    scoreStore = context.read<ScoreStore>();
    scoreStore.onInit(context);
    scoreStore.fetchScoreTypes();

    commonStore = context.read<CommonStore>();
  }

  @override
  void dispose() {
    classroomStore.onDispose(context);
    resultStore.onDispose(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                Center(
                  child: Text(
                    Platform.isWindows
                        ? "BẢNG ĐIỂM ĐÃ QUÉT ĐƯỢC:"
                        : "BẢNG ĐIỂM ĐƯỢC QUÉT",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Observer(builder: (ctx) {
                  if (resultStore.isFetchingResults) {
                    return const LinearProgressIndicator();
                  }
                  return studentResultTable(resultStore.scannedTranscript);
                })
              ],
              if (!resultStore.isFetchingResults &&
                  resultStore.scannedTranscript.isEmpty)
                const Center(
                  child: Text(
                    "KHÔNG QUÉT ĐƯỢC DỮ LIỆU",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Divider(height: 50.0),
              Center(
                child: Text(
                  Platform.isWindows
                      ? "CHỌN BẢNG ĐIỂM ĐỂ ${isImport ? "NHẬP" : "SO SÁNH"}:"
                      : "BẢNG ĐIỂM ${isImport ? "NHẬP" : "SO SÁNH"}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                  // future: ,
                  builder: (ctx) {
                if (classroomStore.isFetchingClassroom) {
                  return const CircularProgressIndicator();
                }
                return customDropdownField<Classroom>(
                    'Lớp học',
                    [...classroomStore.classrooms],
                    (item) =>
                        '${item!.className!} (${item.title ?? ""} - Nhóm: ${item.studyGroup})',
                    (value) {
                  selectedClassroom = value;
                });
              }),
              const SizedBox(height: 10),
              Observer(builder: (ctx) {
                if (scoreStore.isFetchingScore) {
                  return const CircularProgressIndicator();
                }
                return customDropdownField<ScoreType>('Loại điểm',
                    [...scoreStore.scoreTypes], (item) => item!.name!, (value) {
                  selectedScoreType = value;
                });
              }),
              // const SizedBox(height: 10),
              const Divider(height: 50.0),
              Visibility(
                  visible: isImport,
                  child: Column(
                    children: [
                      Text(scoreStore.scoreExcelFile?.path ?? "Không có"),
                      const Divider(height: 50.0),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              // Handle the submit button press event
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(allowedExtensions: [
                                'xlsx',
                                'xls',
                                'csv'
                              ]);

                              if (result != null) {
                                setState(() {
                                  scoreStore.setScoreExcelFile(
                                      File(result.files.single.path!));
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Text(
                              Platform.isWindows
                                  ? 'NHẬP TỆP ĐIỂM EXCEL'
                                  : 'NHẬP EXCEL',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              // Handle the submit button press event
                              if (selectedClassroom?.id == null ||
                                  selectedScoreType?.id == null) return;
                              var result = await scoreStore.importScoreExcel(
                                  selectedClassroom!.id!,
                                  selectedScoreType!.id!);
                              // if (context.mounted) {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(SnackBar(
                              //     content: Text(result.toString()),
                              //     backgroundColor: Colors.blue,
                              //     duration: const Duration(seconds: 2),
                              //   ));
                              // }

                              if (result && context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Cập nhập thành công!"),
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 2),
                                ));
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Cập nhập thất bại!$result"),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text(
                              Platform.isWindows ? 'CẬP NHẬT ĐIỂM' : 'CẬP NHẬT',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),

              Column(
                children: [
                  Visibility(
                    visible: !isImport,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            // Handle the submit button press event
                            if (selectedClassroom != null &&
                                selectedScoreType != null) {
                              await classroomStore.fetchTranscriptWithScoreType(
                                  selectedClassroom!.id!,
                                  selectedScoreType!.id!);

                              var classroomTranscript = {
                                for (var element in classroomStore.transcript)
                                  element.student!.userName: element
                              };
                              var scannedTranscript =
                                  resultStore.scannedTranscript;

                              var list =
                                  List<StudentResult>.empty(growable: true);

                              for (StudentResult sr in scannedTranscript) {
                                if (sr.studentId == null &&
                                    sr.student?.id == null) continue;

                                if (sr.student?.id != null &&
                                    classroomTranscript.keys
                                        .contains(sr.student!.userName)) {
                                  var value = classroomTranscript[
                                      sr.student!.userName]!;
                                  var newValue = StudentResult(
                                      ordinalNumber: sr.ordinalNumber,
                                      classroom: sr.classroom,
                                      score: sr.score!,
                                      scoreType: sr.scoreType,
                                      student: sr.student,
                                      studentId: sr.studentId,
                                      comparedScore: value.score!);
                                  list.add(newValue);
                                } else {
                                  var newValue = StudentResult(
                                      ordinalNumber: sr.ordinalNumber,
                                      classroom: sr.classroom,
                                      score: sr.score!,
                                      scoreType: sr.scoreType,
                                      student: sr.student,
                                      studentId: sr.studentId);
                                  list.add(newValue);
                                }
                              }

                              resultStore.setScannedTranscript(list);
                            }
                          },
                          child: const Text(
                            'TRA CỨU',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  // Handle the submit button press event
                  setState(() {
                    isImport = !isImport;
                  });
                },
                child: Text(
                  isImport ? 'TRA CỨU' : 'NHẬP ĐIỂM',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildInfoRow('Ngày kiểm tra', '20/11/2023'),
              //     _buildInfoRow('Giờ thi', '08'),
              //     _buildInfoRow('Phút', '30'),
              //     _buildInfoRow('Phòng', '101'),
              //   ],
              // ),
              const SizedBox(height: 10),
              Observer(builder: (context) {
                if (classroomStore.transcript.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    Text(
                      Platform.isWindows
                          ? "BẢNG ĐIỂM TRA CỨU ĐƯỢC:"
                          : "BẢNG ĐIỂM TRA CỨU",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    studentResultTable(classroomStore.transcript),
                  ],
                );
              }),
              // _buildSearchedScoreTable(),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.blue,
              //     padding: const EdgeInsets.all(20),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   onPressed: () {
              //     // Handle the submit button press event
              //     Navigator.pushNamed(context, RouteManager.result);
              //   },
              //   child: const Text(
              //     'TIẾN HÀNH KIỂM TRA',
              //     style: TextStyle(
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
