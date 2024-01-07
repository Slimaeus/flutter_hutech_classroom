import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/group_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late ClassroomStore classroomStore;
  late GroupStore groupStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);

    groupStore = context.read<GroupStore>();
    groupStore.onInit(context);
    groupStore
        .fetchClassroomGroupList(classroomStore.selectedClassroom.id!)
        .then((isSuccess) {
      // print('Posts: ${groupStore.items.length}');
      // commentSocketStore.createConnection(groupStore.items[1].id!);
    });
  }

  String formattedDate(DateTime date) {
    final formatter = DateFormat('HH:mm:ss - dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
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
        child: Observer(
          builder: (context) {
            return ListView.builder(
              itemCount: groupStore.items.length,
              itemBuilder: (context, index) {
                final group = groupStore.items[index];

                return Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          group.createDate != null
                              ? formattedDate(DateTime.parse(
                                      '${group.createDate!.toIso8601String()}Z')
                                  .toLocal())
                              : 'Ngày tạo không xác định',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Nhóm trưởng: ${group.leader?.lastName} ${group.leader?.firstName}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Mô tả: ${group.description}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // const Divider(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () {
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(5.0),
                        //         ),
                        //       ),
                        //       child: const Text('DỰ ÁN'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
