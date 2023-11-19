import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/stores/score_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
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
  String? selectedClassroom;

  String? selectedYear;

  String? selectedSemester;

  String? selectedCourse;

  String? selectedGroup;

  int? selectedScoreType;
  late ResultStore resultStore;
  late ClassroomStore classroomStore;
  late ScoreStore scoreStore;

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    scoreStore = context.read<ScoreStore>();
    scoreStore.onInit(context);
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
              //TODO: Render ảnh trả về tại đây!
              const Text(
                "BẢNG ĐIỂM ĐÃ QUÉT ĐƯỢC:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              studentResultTable(resultStore.scannedTranscript),
              const Divider(height: 50.0),
              const Text(
                "CHỌN BẢNG ĐIỂM ĐỂ SO SÁNH:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: classroomStore.fetchClassrooms(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildDropdownField('Lớp học', [
                      ...classroomStore.classrooms.map((c) => c.id!).toList()
                    ], (value) {
                      selectedClassroom = value;
                    });
                  }),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: scoreStore.fetchScoreTypes(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildDropdownField('Loại điểm', [
                      ...scoreStore.scoreTypes
                          .map((c) => c.id!.toString())
                          .toList()
                    ], (value) {
                      selectedScoreType = int.tryParse(value!);
                    });
                  }),
              const SizedBox(height: 10),
              _buildDropdownField('Năm học', ['Year1', 'Year2', 'Year3'],
                  (value) {
                selectedYear = value;
              }),
              const SizedBox(height: 10),
              _buildDropdownField(
                  'Học kỳ', ['Semester1', 'Semester2', 'Semester3'], (value) {
                selectedSemester = value;
              }),
              const SizedBox(height: 10),
              _buildDropdownField(
                  'Mã học phần', ['Course1', 'Course2', 'Course3'], (value) {
                selectedCourse = value;
              }),
              const SizedBox(height: 10),
              _buildDropdownField('Nhóm', ['Group1', 'Group2', 'Group3'],
                  (value) {
                selectedGroup = value;
              }),
              const SizedBox(height: 10),
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
                  if (selectedClassroom != null) {
                    await classroomStore.fetchTranscriptWithScoreType(
                        selectedClassroom!, selectedScoreType!);
                  }
                },
                child: const Text(
                  'TRA CỨU',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //!: Trả về bảng điểm khi tra cứu thành công
              const Text(
                "BẢNG ĐIỂM TRA CỨU ĐƯỢC:",
                style: TextStyle(
                  fontSize: 25,
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
              Observer(
                  builder: (context) =>
                      studentResultTable(classroomStore.transcript)),
              // _buildSearchedScoreTable(),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  // Handle the submit button press event
                  Navigator.pushNamed(context, RouteManager.result);
                },
                child: const Text(
                  'TIẾN HÀNH KIỂM TRA',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, List<String> items, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
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
