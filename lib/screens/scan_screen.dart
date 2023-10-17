import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title, hasLeading: true),
      drawer: customDrawer(context),
      body: const Text('data'),
    );
  }
}
