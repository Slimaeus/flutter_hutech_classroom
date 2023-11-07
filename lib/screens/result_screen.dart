import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: const Text('data'),
    );
  }
}