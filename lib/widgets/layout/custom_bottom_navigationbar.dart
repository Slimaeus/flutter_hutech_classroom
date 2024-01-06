import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  static int staticCurrentIndex = 0;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.popAndPushNamed(context, RouteManager.post);
        break;
      case 1:
        Navigator.popAndPushNamed(context, RouteManager.exercise);
        break;
      case 2:
        Navigator.popAndPushNamed(context, RouteManager.group);
        break;
      case 3:
        Navigator.popAndPushNamed(context, RouteManager.transcript);
        break;
      case 4:
        Navigator.popAndPushNamed(context, RouteManager.member);
        break;
      default:
        break;
    }
    staticCurrentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: staticCurrentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.blue),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {
        onTap(index);
        _handleNavigation(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Thông Báo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Bài Tập',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Nhóm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.poll),
          label: 'Bảng Điểm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Thành Viên',
        ),
      ],
    );
  }
}
