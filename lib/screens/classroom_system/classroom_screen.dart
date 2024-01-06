import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  // Mock data for classrooms
  final List<Map<String, dynamic>> classrooms = [
    {
      'id': 1,
      'title': 'Class 101',
      'lecturerFirstName': 'John',
      'lecturerLastName': 'Doe',
      'room': 'Room 123',
      'class': 'A',
      'bannerImage': PathManager.banner1,
    },
    {
      'id': 2,
      'title': 'Class 101',
      'lecturerFirstName': 'John',
      'lecturerLastName': 'Doe',
      'room': 'Room 123',
      'class': 'A',
      'bannerImage': PathManager.banner1,
    },
    {
      'id': 3,
      'title': 'Class 101',
      'lecturerFirstName': 'John',
      'lecturerLastName': 'Doe',
      'room': 'Room 123',
      'class': 'A',
      'bannerImage': PathManager.banner1,
    },
    {
      'id': 4,
      'title': 'Class 101',
      'lecturerFirstName': 'John',
      'lecturerLastName': 'Doe',
      'room': 'Room 123',
      'class': 'A',
      'bannerImage': PathManager.banner1,
    },
    // Add more classrooms as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: classrooms.length,
          itemBuilder: (context, index) {
            final classroom = classrooms[index];
            return GestureDetector(
              onTap: () {
                // Handle the click on the classroom card, navigate to the class
                // You can use the classroom['id'] to identify the selected class
                // Navigator.pushNamed(context, '/class/${classroom['id']}');
              },
              child: Column(
                children: [
                  Card(
                    elevation: 8.0, // Điều chỉnh độ đậm của shadow tại đây
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                          color: Colors.black12), // Màu của viền
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
                              classroom['bannerImage'],
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                classroom['title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${classroom['lecturerLastName']} ${classroom['lecturerFirstName']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Room: ${classroom['room']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Class: ${classroom['class']}',
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
        ),
      ),
    );
  }
}
