import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/enums/classroom_type.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (context) {
          return ListView.builder(
            itemCount: classroomStore.classrooms.length,
            itemBuilder: (context, index) {
              final classroom = classroomStore.classrooms[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteManager.classroom);
                },
                child: Column(
                  children: [
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                            color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Image.asset(
                                classroom.type ==
                                        ClassroomType.theoryRoom
                                    ? PathManager.banner1
                                    : classroom.type ==
                                            ClassroomType.practiceRoom
                                        ? PathManager.banner2
                                        : PathManager.banner3,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classroom.title ?? "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Giảng viên: ${classroom.lecturer!.lastName} ${classroom.lecturer!.firstName}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Phòng: ${classroom.room}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Lớp: ${classroom.className}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
