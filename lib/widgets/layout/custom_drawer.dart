import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:provider/provider.dart';

Widget customDrawer(BuildContext context) {
  UserStore userStore = context.read<UserStore>();
  userStore.onInit(context);

  return Drawer(
    child: ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: UserAccountsDrawerHeader(
            accountName: Text(
              '${userStore.user.lastName ?? 'N/A'} ${userStore.user.firstName ?? 'N/A'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              userStore.user.userName ?? 'Bạn chưa đăng nhập',
              style: const TextStyle(fontSize: 16),
            ),
            currentAccountPicture: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 55,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Trang Chủ'),
          onTap: () {
            Navigator.pushReplacementNamed(context, RouteManager.home);
          },
        ),
        ListTile(
          leading: const Icon(Icons.class_rounded),
          title: const Text('Lớp Học'),
          onTap: () {
            Navigator.pushReplacementNamed(context, RouteManager.classroom);
          },
        ),
        ListTile(
          leading: const Icon(Icons.assignment),
          title: const Text('Xem Bảng Điểm'),
          onTap: () {
            Navigator.pushReplacementNamed(
                context, RouteManager.studentTranscript);
          },
        ),
        ListTile(
          leading: const Icon(Icons.document_scanner),
          title: const Text('Scan Một Bảng Điểm'),
          onTap: () {
            Navigator.pushReplacementNamed(context, RouteManager.imageInput);
          },
        ),
        ListTile(
          leading: const Icon(Icons.document_scanner),
          title: const Text('Scan Nhiều Bảng Điểm'),
          onTap: () {
            Navigator.pushReplacementNamed(
                context, RouteManager.multipleImageInput);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Hồ Sơ Cá Nhân'),
          onTap: () {
            Navigator.pushReplacementNamed(context, RouteManager.profile);
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Đăng Xuất'),
          onTap: () async {
            await userStore.logout();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RouteManager.login);
            }
          },
        ),
      ],
    ),
  );
}
