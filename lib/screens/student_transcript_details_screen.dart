import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_hutech_classroom/widgets/tables/student_result_table.dart';

class StudentTranscriptDetailsScreen extends StatelessWidget {
  const StudentTranscriptDetailsScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title, hasLeading: true),
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
                                  _buildInfoRow('Năm học', '2023'),
                                  _buildInfoRow('Học kỳ', '1'),
                                  _buildInfoRow('Mã học phần', 'ABC123'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow('Học phần', 'Tên học phần'),
                                  _buildInfoRow('Số tín chỉ', '3'),
                                  _buildInfoRow('Nhóm', 'Group A'),
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
                studentResultTable([
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
                ]),
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
                studentResultTable([
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
                ]),
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
