import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
                const SizedBox(height: 70),
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
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () async {
                                    var result = await FilePicker.platform
                                        .getDirectoryPath();
                                    print(result);
                                    // if (resultStore.croppedImage == null)
                                    //   return;
                                    // var url = Uri.parse(
                                    //     "https://localhost:7153/api/v1/Features/Files/ReceiveMultipleFile");
                                    // var request = http.MultipartRequest('POST', url);
                                    // var fileModels = <FileModel>[
                                    //   FileModel(
                                    //       classroomId: 'classroomId',
                                    //       file: resultStore.croppedImage!)
                                    // ];
                                    // for (var i = 0; i < fileModels.length; i++) {
                                    //   var fileModel = fileModels[i];
                                    //   var file = await http.MultipartFile.fromPath(
                                    //     'fileModels[$i].file', // field name
                                    //     fileModel.file.path, // file path
                                    //     filename:
                                    //         path.basename(fileModel.file.path), // file name
                                    //   );
                                    //   request.files.add(file);
                                    //   request.fields['fileModels[$i].classroomId'] =
                                    //       fileModel.classroomId;
                                    // }
                                    // var response = await request.send();
                                    // if (response.statusCode == 200) {
                                    //   print(await response.stream.bytesToString());
                                    //   print("Uploaded!");
                                    // } else {
                                    //   print("Failed to upload file.");
                                    // }

                                    var url = Uri.parse(
                                        "https://hutechclassroom.azurewebsites.net/api/v1/Features/Files/GetExcel");

                                    var request = http.Request('GET', url);
                                    // var fileModels = resultStore.croppedImages;
                                    // for (var i = 0;
                                    //     i < fileModels.length;
                                    //     i++) {
                                    // var fileModel = fileModels[i];
                                    // var file =
                                    //     await http.MultipartFile.fromPath(
                                    //   'files', // field name
                                    //   fileModel.path, // file path
                                    //   filename: path.basename(
                                    //       fileModel.path), // file name
                                    // );
                                    // request.files.add(file);
                                    request.headers.addAll({
                                      'Authorization':
                                          'Bearer ${commonStore.jwt}'
                                    });
                                    // request.fields['fileModels[$i].classroomId'] =
                                    //     fileModel.classroomId;
                                    // }
                                    var response = await request.send();
                                    if (response.statusCode == 200) {
                                      var file = File("$result/a.xlsx");
                                      if (!await file.exists()) {
                                        await file.create();
                                      }
                                      await file.writeAsBytes(
                                          await response.stream.toBytes());
                                      print("Uploaded!");
                                    } else {
                                      print(response.statusCode);
                                      print("Failed to upload file.");
                                    }
                                  },
                                  icon: const Icon(Icons.file_upload)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteManager.studentTranscript);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  minimumSize: const Size(200, 200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                      size: 50,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Xem Bảng Điểm',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteManager.imageInput);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  minimumSize: const Size(200, 200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.scanner,
                                      size: 50,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Scan Kiểm Tra',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteManager.multipleImageInput);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  minimumSize: const Size(200, 200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.scanner,
                                      size: 50,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Scan Kiểm Tra nhiều bảng điểm',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
