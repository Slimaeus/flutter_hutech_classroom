import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PostCommentScreen extends StatefulWidget {
  const PostCommentScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  late ClassroomStore classroomStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    // classroomStore.fetchClassrooms();
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
            child: Text("CHI TIẾT THÔNG BÁO & NHẬN XÉT"),
          );
        }),
      ),
    );
  }
}
