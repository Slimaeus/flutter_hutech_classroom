import 'package:flutter/material.dart';

Widget customTable(List<Widget> titleRow, List<List<Widget>> dataRows) {
  return Table(
    border: TableBorder.all(),
    columnWidths: const {
      0: FixedColumnWidth(100.0),
      5: FixedColumnWidth(100.0),
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
