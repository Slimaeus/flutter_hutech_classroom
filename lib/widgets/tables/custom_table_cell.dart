import 'package:flutter/material.dart';

Widget customTableCell(String value, {bool alignLeft = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TableCell(
      child: Align(
        alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
        child: Text(value),
      ),
    ),
  );
}
