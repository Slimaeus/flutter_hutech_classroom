import 'package:flutter/material.dart';

Widget customTable(List<Widget> titleRow, List<List<Widget>> dataRows) {
  return Table(
    border: TableBorder.all(),
    columnWidths: const {
      0: FlexColumnWidth(),
      1: FlexColumnWidth(),
      2: FlexColumnWidth(),
      3: FlexColumnWidth(),
      4: FlexColumnWidth(),
      5: FlexColumnWidth(),
    },
    children: [
      TableRow(
        children: titleRow,
      ),
      ...dataRows.map((row) => TableRow(children: row)).toList(),
      // Thêm các hàng khác tương tự ở đây
    ],
  );
}
