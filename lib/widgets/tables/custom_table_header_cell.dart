import 'package:flutter/material.dart';

Widget customTableHeaderCell(String value) {
  return Container(
    color: Colors.blue,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          value,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
  );
}
