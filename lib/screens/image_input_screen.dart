import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key, required this.title});

  final String title;

  @override
  State<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  late CommonStore commonStore;
  late ResultStore resultStore;
  final _cropController = CropController();
  int times = 0;

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
            mainAxisSize: MainAxisSize.min,
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

                  if (result != null &&
                      ['jpg', 'png'].contains(p
                          .extension(result.files.single.path!)
                          .substring(1))) {
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
              if (resultStore.resultImage != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: resultStore.resultImage!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        return Crop(
                          image: snapshot.data!,
                          controller: _cropController,
                          onCropped: (image) async {
                            // ! After change the Transcript, Crop Widget updated but
                            // ! it crop the previous Transcript not the new one
                            File croppedFile = File(
                                'cropped_${times}_${p.basename(resultStore.resultImage!.path)}');
                            File croppedImage =
                                await croppedFile.writeAsBytes(image);
                            setState(() {
                              resultStore.setCroppedImage(croppedImage);
                            });
                            File previousFile = File(
                                'cropped_${times - 1}_${p.basename(resultStore.resultImage!.path)}');
                            if (times > 0 && await previousFile.exists()) {
                              await previousFile.delete();
                            }
                            times++;
                          },
                        );
                      }),
                ),
              if (resultStore.resultImage != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: _cropController.crop,
                  child: const Text(
                    'CẮT ẢNH',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
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
                        if (resultStore.croppedImage != null)
                          Text(resultStore.croppedImage!.path),
                        if (resultStore.croppedImage != null)
                          Image.file(resultStore.croppedImage as File),
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
                  if (mounted) {
                    Navigator.pushNamed(context, RouteManager.comparison);
                  }

                  // for (var element in resultStore.results) {
                  //   print(element.ordinalNumber);
                  // }
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
