import 'package:flutter/material.dart';

Widget customTableCell(String value,
    {bool alignLeft = false, Color color = Colors.black}) {
  return TableCell(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
        child: Text(
          value,
          style: TextStyle(color: color),
        ),
      ),
    ),
  );
}
