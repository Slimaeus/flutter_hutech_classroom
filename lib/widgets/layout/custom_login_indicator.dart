import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';

Widget customLoginIndicator(BuildContext context) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(PathManager.logoHutechScanSystem,
          height: MediaQuery.of(context).size.height * 0.1),
      SizedBox(
          width: Platform.isWindows
              ? MediaQuery.of(context).size.width * 0.17
              : MediaQuery.of(context).size.width * 0.7,
          child: const LinearProgressIndicator()),
    ],
  ));
}
