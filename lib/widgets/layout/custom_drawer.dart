import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

Widget customDrawer(BuildContext context) {
  UserStore userStore = context.read<UserStore>();

  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: const Text('Cài đặt'),
        ),
        ListTile(
          title: Observer(builder: (context) {
            return Row(
              children: [
                const Text("Sinh viên: "),
                Text(userStore.user.userName ?? 'Bạn chưa đăng nhập'),
              ],
            );
          }),
        ),
        ListTile(
          title: FloatingActionButton(
            heroTag: "LogButton",
            child: Builder(builder: (context) {
              return Text(
                  userStore.user.id != null ? 'Đăng xuất' : 'Đăng nhập');
            }),
            onPressed: () {
              if (userStore.user.id != null) {
                userStore.resetValue();
              }
              Navigator.pushReplacementNamed(context, RouteManager.login);
            },
          ),
        ),
      ],
    ),
  );
}
