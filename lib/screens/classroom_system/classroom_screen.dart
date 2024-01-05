import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:provider/provider.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  @override
  Widget build(BuildContext context) {
    // UserStore userStore = context.watch<UserStore>();

    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Platform.isWindows
                  ? MediaQuery.of(context).size.height * 0.01
                  : MediaQuery.of(context).size.height * 0.01,
              horizontal: Platform.isWindows
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * 0.01),
          child: Center(
            child: Observer(builder: (context) {
              return const Column(
                children: [],
              );
            }),
          ),
        ),
      ),
    );
  }
}
