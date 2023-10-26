import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
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
              return Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: const CircleAvatar(
                                radius: 60,
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${userStore.user.lastName} ${userStore.user.firstName}',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  userStore.user.roles.isNotEmpty
                                      ? userStore.user.roles[0]
                                      : '',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Card(
                              elevation: 3,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        child: const Text(
                                          'Thông tin cá nhân',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
                                        initialValue:
                                            userStore.user.faculty?.name ??
                                                'N/A',
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Khoa',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Card(
                              elevation: 3,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: const Text(
                                          'Liên kết',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              PathManager
                                                  .logoHutechAdministration,
                                              height: 60,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "https://hutechclassroomweb.azurewebsites.net/",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(height: 5),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              PathManager.logoHutechClassroom,
                                              height: 60,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "https://hutech-classroom-edu.vercel.app/",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
