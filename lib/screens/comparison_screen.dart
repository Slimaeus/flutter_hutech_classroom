import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/score_type.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
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
  }

  @override
  void dispose() {
    classroomStore.onDispose(context);
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
              const Center(
                child: Text(
                  "BẢNG ĐIỂM ĐÃ QUÉT ĐƯỢC:",
                  style: TextStyle(
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
              }),
              const Divider(height: 50.0),
              const Text(
                "CHỌN BẢNG ĐIỂM ĐỂ SO SÁNH:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
                            child: const Text(
                              'NHẬP TỆP ĐIỂM EXCEL',
                              style: TextStyle(
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
                              await scoreStore.importScoreExcel(
                                  selectedClassroom!.id!,
                                  selectedScoreType!.id!);
                              if (mounted) {
                                Navigator.pushNamed(
                                    context, RouteManager.comparison);
                              }
                            },
                            child: const Text(
                              'CẬP NHẬT ĐIỂM',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),

              Row(
                children: [
                  Visibility(
                    visible: !isImport,
                    child: Row(
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
                            if (selectedClassroom != null &&
                                selectedScoreType != null) {
                              await classroomStore.fetchTranscriptWithScoreType(
                                  selectedClassroom!.id!,
                                  selectedScoreType!.id!);
                            }
                          },
                          child: const Text(
                            'TRA CỨU',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                      ],
                    ),
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
                ],
              ),
              const SizedBox(height: 20),
              //!: Trả về bảng điểm khi tra cứu thành công

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
                    const Text(
                      "BẢNG ĐIỂM TRA CỨU ĐƯỢC:",
                      style: TextStyle(
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
