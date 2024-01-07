import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/post_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ClassroomStore classroomStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);

    PostStore postStore = context.read<PostStore>();
    postStore.onInit(context);
    postStore
        .fetchClassroomPostList(classroomStore.selectedClassroom.id!)
        .then((isSuccess) {
      // print('Posts: ${postStore.items.length}');
    });
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
          return const Center(
            child: Text("BÀI ĐĂNG"),
          );
        }),
      ),
    );
  }
}
