import 'dart:io';

import 'package:flutter/material.dart';

Widget customTable(List<Widget> titleRow, List<List<Widget>> dataRows) {
  return Table(
    border: TableBorder.all(),
    columnWidths: Platform.isWindows
        ? {}
        : const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(6),
            2: FlexColumnWidth(5),
            3: FlexColumnWidth(5),
          },
    defaultColumnWidth: const FlexColumnWidth(),
    children: [
      TableRow(
        children: titleRow,
      ),
      ...dataRows.map((row) => TableRow(children: row)).toList(),
      // Thêm các hàng khác tương tự ở đây
    ],
  );
}
