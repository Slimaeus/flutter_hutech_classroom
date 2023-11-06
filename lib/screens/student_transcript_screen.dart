import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';

class StudentTranscriptScreen extends StatefulWidget {
  const StudentTranscriptScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<StudentTranscriptScreen> createState() =>
      _StudentTranscriptScreenState();
}

class _StudentTranscriptScreenState extends State<StudentTranscriptScreen> {
  String? selectedYear;

  String? selectedSemester;

  String? selectedCourse;

  String? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1,
                horizontal: MediaQuery.of(context).size.width * 0.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'TRA CỨU BẢNG ĐIỂM',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  PathManager.pic3,
                  height: 350,
                ),
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
                //Nhóm thực hành
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    // Handle the submit button press event
                    Navigator.pushNamed(
                        context, RouteManager.studentTranscriptDetails);
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
        ),
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
}
