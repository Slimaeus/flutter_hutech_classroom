import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/extensions/semester_extensions.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_hutech_classroom/widgets/tables/student_result_table.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class StudentTranscriptDetailsScreen extends StatefulWidget {
  const StudentTranscriptDetailsScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<StudentTranscriptDetailsScreen> createState() =>
      _StudentTranscriptDetailsScreenState();
}

class _StudentTranscriptDetailsScreenState
    extends State<StudentTranscriptDetailsScreen> {
  late ResultStore resultStore;
  late ClassroomStore classroomStore;
  late CommonStore commonStore;

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
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
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thông tin chi tiết bảng điểm:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        buildInfoRows(classroomStore)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 150),
                    const Text(
                      'BẢNG ĐIỂM QUÁ TRÌNH',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          var result =
                              await FilePicker.platform.getDirectoryPath();
                          var url = Uri.parse(
                              "https://hutechclassroom.azurewebsites.net/api/v1/Classrooms/${classroomStore.selectedClassroom.id}/Scores/1/Export");

                          var request = http.Request('GET', url);
                          request.headers.addAll(
                              {'Authorization': 'Bearer ${commonStore.jwt}'});
                          var response = await request.send();
                          if (response.statusCode == 200) {
                            var file = File(
                                "$result/${classroomStore.selectedClassroom.className}_${classroomStore.selectedClassroom.subject?.code ?? "e"}_DiemQuaTrinh.xlsx");
                            if (!await file.exists()) {
                              await file.create();
                            }
                            await file
                                .writeAsBytes(await response.stream.toBytes());
                            developer.log("Uploaded!");
                          } else {
                            developer.log("Failed to upload file.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'XUẤT EXCEL',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     _buildInfoRow('Ngày kiểm tra', '20/11/2023'),
                //     _buildInfoRow('Giờ thi', '08'),
                //     _buildInfoRow('Phút', '30'),
                //     _buildInfoRow('Phòng', '101'),
                //   ],
                // ),
                // const SizedBox(height: 10),
                studentResultTable(classroomStore.transcript
                    .where((t) => t.scoreType?.id == 1)
                    .toList()),
                const Divider(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    const Text(
                      'BẢNG ĐIỂM CUỐI KỲ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          var result =
                              await FilePicker.platform.getDirectoryPath();
                          var url = Uri.parse(
                              "https://hutechclassroom.azurewebsites.net/api/v1/Classrooms/${classroomStore.selectedClassroom.id}/Scores/2/Export");

                          var request = http.Request('GET', url);
                          request.headers.addAll(
                              {'Authorization': 'Bearer ${commonStore.jwt}'});
                          var response = await request.send();
                          if (response.statusCode == 200) {
                            var file = File(
                                "$result/${classroomStore.selectedClassroom.className}_${classroomStore.selectedClassroom.subject?.code ?? "e"}_DiemCuoiKy.xlsx");
                            if (!await file.exists()) {
                              await file.create();
                            }
                            await file
                                .writeAsBytes(await response.stream.toBytes());
                            developer.log("Uploaded!");
                          } else {
                            developer.log("Failed to upload file.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'XUẤT EXCEL',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     _buildInfoRow('Ngày kiểm tra', '30/11/2023'),
                //     _buildInfoRow('Giờ thi', '10'),
                //     _buildInfoRow('Phút', '120'),
                //     _buildInfoRow('Phòng', '111'),
                //   ],
                // ),
                // const SizedBox(height: 10),
                studentResultTable(classroomStore.transcript
                    .where((t) => t.scoreType?.id == 2)
                    .toList()),
                const Divider(height: 50.0),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tình trạng cập nhật:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const Text(
                            '- Cập nhật lúc 12:00 ngày 12/02/2022 từ hệ thống HUTECH CLASSROOM.'),
                        const SizedBox(height: 5),
                        // const Text(
                        //     '- Đã Scan kiểm tra lúc 12:00 ngày 14/02/2022.'),
                        // const SizedBox(height: 5),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Handle the submit button press event
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     foregroundColor: Colors.white,
                        //     backgroundColor: Colors.blue,
                        //     padding: const EdgeInsets.all(18),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //   ),
                        //   child: const Text(
                        //     'Xem kết quả Scan',
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //     ),
                        //   ),
                        // ),
                        // //Trường hợp chưa Scan
                        // const SizedBox(height: 5),
                        const Text('- Chưa Scan kiểm tra.'),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            // Handle the submit button press event
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Thực hiện Scan',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    ),
  );
}

String truncateString(String input, int maxLength) {
  return input.length <= maxLength
      ? input
      : '${input.substring(0, maxLength)}...';
}

Widget buildInfoRows(ClassroomStore classroomStore) {
  if (Platform.isAndroid) {
    // Use Column layout for Android
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'Năm học',
          classroomStore.selectedClassroom.schoolYear ?? "Không có",
        ),
        _buildInfoRow(
          'Học kỳ',
          classroomStore.selectedClassroom.semester?.toText() ?? "Không có",
        ),
        _buildInfoRow(
          'Mã học phần',
          classroomStore.selectedClassroom.subject?.code ?? "Không có",
        ),
        _buildInfoRow(
          'Học phần',
          classroomStore.selectedClassroom.subject?.title ?? "Không có",
        ),
        _buildInfoRow(
          'Số tín chỉ',
          classroomStore.selectedClassroom.subject?.totalCredits.toString() ??
              "Không có",
        ),
        _buildInfoRow(
          'Nhóm',
          classroomStore.selectedClassroom.studyGroup ??
              classroomStore.selectedClassroom.practicalStudyGroup ??
              "Không có",
        ),
      ],
    );
  } else {
    // Use Row layout for other platforms
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                'Năm học',
                classroomStore.selectedClassroom.schoolYear ?? "Không có",
              ),
              _buildInfoRow(
                'Học kỳ',
                classroomStore.selectedClassroom.semester?.toText() ??
                    "Không có",
              ),
              _buildInfoRow(
                'Mã học phần',
                classroomStore.selectedClassroom.subject?.code ?? "Không có",
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                'Học phần',
                classroomStore.selectedClassroom.subject?.title ?? "Không có",
              ),
              _buildInfoRow(
                'Số tín chỉ',
                classroomStore.selectedClassroom.subject?.totalCredits
                        .toString() ??
                    "Không có",
              ),
              _buildInfoRow(
                'Nhóm',
                classroomStore.selectedClassroom.studyGroup ??
                    classroomStore.selectedClassroom.practicalStudyGroup ??
                    "Không có",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
