import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:intl/intl.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class Group {
  final String name;
  final DateTime createDate;
  final String leaderFirstName;
  final String leaderLastName;
  final String description;

  Group({
    required this.name,
    required this.createDate,
    required this.leaderFirstName,
    required this.leaderLastName,
    required this.description,
  });
}

class _GroupScreenState extends State<GroupScreen> {
  int _currentIndex = 0;

  final List<Group> _groups = [
    Group(
      name: 'Group 1',
      createDate: DateTime.now(),
      leaderFirstName: 'John',
      leaderLastName: 'Doe',
      description: 'This is group 1.',
    ),
    Group(
      name: 'Group 2',
      createDate: DateTime.now().subtract(const Duration(days: 3)),
      leaderFirstName: 'Jane',
      leaderLastName: 'Smith',
      description: 'This is group 2.',
    ),
    Group(
      name: 'Group 3',
      createDate: DateTime.now().subtract(const Duration(days: 5)),
      leaderFirstName: 'Alice',
      leaderLastName: 'Johnson',
      description: 'This is group 3.',
    ),
  ];

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
        child: ListView.builder(
          itemCount: _groups.length,
          itemBuilder: (context, index) {
            final group = _groups[index];

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
                      group.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formattedDate(group.createDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Nhóm trưởng: ${group.leaderLastName} ${group.leaderFirstName}',
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
                    //         // TODO: Chuyển hướng đến trang dự án
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
        ),
      ),
    );
  }
}
