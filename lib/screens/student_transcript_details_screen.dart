import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/extensions/semester_extensions.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_hutech_classroom/widgets/tables/student_result_table.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(
                                      'Năm học',
                                      classroomStore
                                              .selectedClassroom.schoolYear ??
                                          "Không có"),
                                  _buildInfoRow(
                                      'Học kỳ',
                                      classroomStore.selectedClassroom.semester
                                              ?.toText() ??
                                          "Không có"),
                                  _buildInfoRow(
                                      'Mã học phần',
                                      classroomStore.selectedClassroom.subject
                                              ?.code ??
                                          "Không có"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(
                                      'Học phần',
                                      classroomStore.selectedClassroom.subject
                                              ?.title ??
                                          "Không có"),
                                  _buildInfoRow(
                                      'Số tín chỉ',
                                      classroomStore.selectedClassroom.subject
                                              ?.totalCredits
                                              .toString() ??
                                          "Không có"),
                                  _buildInfoRow(
                                      'Nhóm',
                                      classroomStore
                                              .selectedClassroom.studyGroup ??
                                          classroomStore.selectedClassroom
                                              .practicalStudyGroup ??
                                          "Không có"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'BẢNG ĐIỂM QUÁ TRÌNH',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoRow('Ngày kiểm tra', '20/11/2023'),
                    _buildInfoRow('Giờ thi', '08'),
                    _buildInfoRow('Phút', '30'),
                    _buildInfoRow('Phòng', '101'),
                  ],
                ),
                const SizedBox(height: 10),
                studentResultTable(classroomStore.transcript
                    .where((t) => t.scoreType?.id == 1)
                    .toList()),
                const Divider(height: 50.0),
                const Text(
                  'BẢNG ĐIỂM CUỐI KỲ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoRow('Ngày kiểm tra', '30/11/2023'),
                    _buildInfoRow('Giờ thi', '10'),
                    _buildInfoRow('Phút', '120'),
                    _buildInfoRow('Phòng', '111'),
                  ],
                ),
                const SizedBox(height: 10),
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
                        const Text(
                            '- Đã Scan kiểm tra lúc 12:00 ngày 14/02/2022.'),
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
                            'Xem kết quả Scan',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        //Trường hợp chưa Scan
                        const SizedBox(height: 5),
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
}
