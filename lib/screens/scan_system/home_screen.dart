import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserStore _userStore;
  late CommonStore commonStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read<UserStore>();
    commonStore = context.read<CommonStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 35),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Chào mừng bạn đã trở lại!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Observer(builder: (context) {
                    return Column(
                      children: [
                        Text(
                          '${_userStore.user.userName ?? 'N/A'} - ${_userStore.user.lastName ?? 'N/A'} ${_userStore.user.firstName ?? 'N/A'}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  }),
                ),
                Image.asset(
                  PathManager.pic1,
                  height: 300,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      Platform.isWindows ? 8.0 : 5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          RouteManager.classroom);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      minimumSize: Size(
                                          Platform.isWindows ? 200 : 120,
                                          Platform.isWindows ? 200 : 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.class_rounded,
                                          size: 50,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          Platform.isWindows
                                              ? 'Lớp Học'
                                              : 'Lớp Học',
                                          style: TextStyle(
                                              fontSize:
                                                  Platform.isWindows ? 20 : 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      Platform.isWindows ? 8.0 : 5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          RouteManager.studentTranscript);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      minimumSize: Size(
                                          Platform.isWindows ? 200 : 120,
                                          Platform.isWindows ? 200 : 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.assignment,
                                          size: 50,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          Platform.isWindows
                                              ? 'Xem bảng Điểm'
                                              : 'Xem',
                                          style: TextStyle(
                                              fontSize:
                                                  Platform.isWindows ? 20 : 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      Platform.isWindows ? 8.0 : 5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          RouteManager.multipleImageInput);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      minimumSize: Size(
                                          Platform.isWindows ? 200 : 120,
                                          Platform.isWindows ? 200 : 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.document_scanner_rounded,
                                          size: 50,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          Platform.isWindows
                                              ? 'Scan Nhiều\nBảng điểm'
                                              : 'Scan nhiều',
                                          style: TextStyle(
                                              fontSize:
                                                  Platform.isWindows ? 20 : 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      Platform.isWindows ? 8.0 : 5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RouteManager.imageInput);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      minimumSize: Size(
                                          Platform.isWindows ? 200 : 120,
                                          Platform.isWindows ? 200 : 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.document_scanner,
                                          size: 50,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          Platform.isWindows
                                              ? 'Scan Kiểm Tra'
                                              : 'Scan',
                                          style: TextStyle(
                                              fontSize:
                                                  Platform.isWindows ? 20 : 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
