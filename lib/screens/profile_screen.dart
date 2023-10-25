import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Center(
            child: Observer(builder: (context) {
              return Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.03,
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        child: Icon(
                          Icons.person,
                          size: 120,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userStore.user.roles.isNotEmpty
                            ? userStore.user.roles[0]
                            : '',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue:
                            '${userStore.user.lastName} ${userStore.user.firstName}',
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Họ và Tên',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: userStore.user.userName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Mã đăng nhập',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: userStore.user.faculty?.name ?? 'N/A',
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Khoa',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
