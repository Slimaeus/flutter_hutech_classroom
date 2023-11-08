import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/student_result.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table_cell.dart';
import 'package:flutter_hutech_classroom/widgets/tables/custom_table_header_cell.dart';

Widget studentResultTable(List<StudentResult> studentResult) {
  return customTable([
    customTableHeaderCell('STT'),
    customTableHeaderCell('Mã SV'),
    customTableHeaderCell('Họ SV'),
    customTableHeaderCell('Tên SV'),
    customTableHeaderCell('Mã lớp'),
    customTableHeaderCell('Điểm'),
  ], [
    ...studentResult.map((r) => [
          customTableCell(r.ordinalNumber.toString()),
          if (r.student != null &&
              r.student?.userName != null &&
              r.student?.firstName != null &&
              r.student?.lastName != null) ...[
            customTableCell(r.student!.userName!),
            customTableCell(r.student!.lastName!, alignLeft: true),
            customTableCell(r.student!.firstName!, alignLeft: true),
          ],
          if (r.classroom != null && r.classroom?.className != null)
            customTableCell(r.classroom!.className!, alignLeft: true),
          customTableCell(r.score.toString()),
        ])
  ]);
}
