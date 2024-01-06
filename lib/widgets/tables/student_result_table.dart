import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table_cell.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table_header_cell.dart';

Widget studentResultTable(List<StudentResult> studentResult) {
  return customTable([
    customTableHeaderCell('STT'),
    customTableHeaderCell('MSSV'),
    if (Platform.isWindows) ...[
      customTableHeaderCell('Họ'),
      customTableHeaderCell('Tên'),
      customTableHeaderCell('Lớp'),
    ],
    customTableHeaderCell('Điểm'),
    if (studentResult.any((element) => element.comparedScore != null))
      customTableHeaderCell('Điểm hệ thống'),
  ], [
    ...studentResult.map((r) => [
          customTableCell(r.ordinalNumber.toString()),
          if (r.student != null && r.student?.userName != null)
            customTableCell(r.student!.userName!),
          if (Platform.isWindows)
            if (r.student != null &&
                r.student?.userName != null &&
                r.student?.firstName != null &&
                r.student?.lastName != null) ...[
              customTableCell(r.student!.lastName!, alignLeft: true),
              customTableCell(r.student!.firstName!, alignLeft: true),
            ] else ...[
              customTableCell(r.studentId ?? ""),
              customTableCell("", alignLeft: true),
              customTableCell("", alignLeft: true),
            ],
          if (Platform.isWindows)
            if (r.classroom != null && r.classroom?.className != null)
              customTableCell(r.classroom!.className!, alignLeft: true)
            else if (r.student?.className != null)
              customTableCell(
                  r.student?.className != null ? r.student!.className! : "",
                  alignLeft: true)
            else
              customTableCell("", alignLeft: true),
          customTableCell(
              r.score != null && r.score != -1 ? r.score.toString() : "",
              color: r.comparedScore != null
                  ? r.score == r.comparedScore
                      ? Colors.green
                      : Colors.red
                  : Colors.black),
          if (studentResult.any((element) => element.comparedScore != null))
            customTableCell(
                r.comparedScore != null && r.comparedScore != -1
                    ? r.comparedScore.toString()
                    : "",
                color: r.comparedScore != null
                    ? r.score == r.comparedScore
                        ? Colors.green
                        : Colors.red
                    : Colors.black),
        ])
  ]);
}
