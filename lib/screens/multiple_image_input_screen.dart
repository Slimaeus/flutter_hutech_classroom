import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/score_type.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/stores/score_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path;

class MultipleImageInputScreen extends StatefulWidget {
  const MultipleImageInputScreen({super.key, required this.title});

  final String title;

  @override
  State<MultipleImageInputScreen> createState() =>
      _MultipleImageInputScreenState();
}

class _MultipleImageInputScreenState extends State<MultipleImageInputScreen> {
  Classroom? selectedClassroom;
  ScoreType? selectedScoreType;
  late ClassroomStore classroomStore;
  late ScoreStore scoreStore;
  late CommonStore commonStore;
  late ResultStore resultStore;
  final _cropController = CropController();
  int times = 0;

  @override
  void initState() {
    super.initState();
    resultStore = context.read<ResultStore>();
    resultStore.onInit(context);
    resultStore.resetValue();
    commonStore = context.read<CommonStore>();
    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);
    classroomStore.fetchClassrooms();
    scoreStore = context.read<ScoreStore>();
    scoreStore.onInit(context);
    scoreStore.fetchScoreTypes();
  }

  @override
  void dispose() {
    classroomStore.onDispose(context);
    // resultStore.onDispose(context);
    super.dispose();
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
              // const Text(
              //   "CHỌN THÔNG TIN",
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Observer(
              //     // future: ,
              //     builder: (ctx) {
              //   if (classroomStore.isFetchingClassroom) {
              //     return const CircularProgressIndicator();
              //   }
              //   return customDropdownField<Classroom>(
              //       'Lớp học',
              //       [...classroomStore.classrooms],
              //       (item) =>
              //           '${item!.className!} (${item.title ?? ""} - Nhóm: ${item.studyGroup})',
              //       (value) {
              //     selectedClassroom = value;
              //   });
              // }),
              // const SizedBox(height: 10),
              // Observer(builder: (ctx) {
              //   if (scoreStore.isFetchingScore) {
              //     return const CircularProgressIndicator();
              //   }
              //   return customDropdownField<ScoreType>('Loại điểm',
              //       [...scoreStore.scoreTypes], (item) => item!.name!, (value) {
              //     selectedScoreType = value;
              //   });
              // }),
              // const SizedBox(height: 10),
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
                      ['jpg', 'png'].contains(path
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
                            Directory tempDir = await getTemporaryDirectory();
                            String tempPath = tempDir.path;
                            File croppedFile = File(
                                '$tempPath/cropped_${times}_${path.basename(resultStore.resultImage!.path)}');
                            File croppedImage =
                                await croppedFile.writeAsBytes(image);
                            setState(() {
                              resultStore.setCroppedImage(croppedImage);
                            });
                            // File previousFile = File(
                            //     'cropped_${times - 1}_${path.basename(resultStore.resultImage!.path)}');
                            // if (times > 0 && await previousFile.exists()) {
                            //   await previousFile.delete();
                            // }
                            times++;
                          },
                        );
                      }),
                ),
              const SizedBox(height: 10),
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
              if (resultStore.croppedImages.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: resultStore.resultImage != null
                      ? Image.file(resultStore.resultImage as File).height
                      : 500,
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Observer(builder: (context) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: resultStore.croppedImages
                                .map((element) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Ảnh',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(element.path),
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                            child: Image.file(
                                              element,
                                              height: 400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              if (resultStore.croppedImages.isNotEmpty)
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
                      Navigator.popAndPushNamed(
                          context, RouteManager.mulipleComparision);
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
