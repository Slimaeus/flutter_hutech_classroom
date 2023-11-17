import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key, required this.title});

  final String title;

  @override
  State<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  File? _file;
  late CommonStore commonStore;
  late ResultStore resultStore;

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    resultStore.onInit(context);
    commonStore = context.read<CommonStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  // Handle the submit button press event
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(allowedExtensions: ['jpg', 'png']);

                  if (result != null) {
                    setState(() {
                      resultStore.setImage(File(result.files.single.path!));
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Text(
                  'NHẬP ẢNH',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //TODO: Handle cắt ảnh tại đây!
              SizedBox(
                width: double.infinity,
                height: resultStore.resultImage != null
                    ? Image.file(resultStore.resultImage as File).height
                    : 500,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ảnh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (resultStore.resultImage != null)
                          Text(resultStore.resultImage!.path),
                        if (resultStore.resultImage != null)
                          Image.file(resultStore.resultImage as File)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  // Handle the submit button press event
                  // Navigator.pushNamed(context, RouteManager.scan);
                  await resultStore.getResults();

                  for (var element in resultStore.results) {
                    print(element.ordinalNumber);
                  }
                },
                child: const Text(
                  'TIẾP TỤC',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
