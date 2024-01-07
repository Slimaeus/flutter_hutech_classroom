import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late ClassroomStore classroomStore;
  int _currentIndex = 0;

  // Mock data for testing
  final List<Map<String, String>> members = [
    {
      'lastname': 'Nguyễn',
      'firstname': 'Văn A',
      'username': 'A12345',
      'classname': 'C1801',
      'email': 'vana@gmail.com',
    },
    {
      'lastname': 'Nguyễn',
      'firstname': 'Văn B',
      'username': 'A12345',
      'classname': 'C1801',
      'email': 'vana@gmail.com',
    },
    // Add more mock data as needed
  ];

  @override
  void initState() {
    super.initState();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    // classroomStore.fetchClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Giảng viên
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'GIẢNG VIÊN: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${classroomStore.selectedClassroom.lecturer?.lastName} ${classroomStore.selectedClassroom.lecturer?.firstName}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Danh sách sinh viên
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'DANH SÁCH SINH VIÊN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                // Thêm Expanded ở đây
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            '${member['lastname']} ${member['firstname']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    title: Text(
                                      '${member['lastname']} ${member['firstname']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 8),
                                        Text(
                                          'Mã số sinh viên: ${member['username']}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Lớp: ${member['classname']}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Email: ${member['email']}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Đóng'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
