import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_dropdown_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class StudentTranscriptScreen extends StatefulWidget {
  const StudentTranscriptScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<StudentTranscriptScreen> createState() =>
      _StudentTranscriptScreenState();
}

class _StudentTranscriptScreenState extends State<StudentTranscriptScreen> {
  Classroom? selectedClassroom;
  late ClassroomStore classroomStore;

  @override
  void initState() {
    super.initState();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    classroomStore.fetchClassrooms();
  }

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
                  onPressed: () async {
                    // Handle the submit button press event
                    if (selectedClassroom != null) {
                      classroomStore.setClassroom(selectedClassroom!);
                      await classroomStore
                          .fetchTranscript(selectedClassroom!.id!);
                      if (mounted) {
                        Navigator.pushNamed(
                            context, RouteManager.studentTranscriptDetails);
                      }
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
        ),
      ),
    );
  }
}
