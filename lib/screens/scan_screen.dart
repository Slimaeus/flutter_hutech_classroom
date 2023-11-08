import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title, hasLeading: true),
      endDrawer: customDrawer(context),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Đưa ảnh qua tại đây!
              const SizedBox(
                width: double.infinity,
                height: 500,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ảnh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  // Handle the submit button press event
                },
                child: const Text(
                  'TIẾN HÀNH SCAN',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //TODO: Render ảnh trả về tại đây!
              const Text(
                "BẢNG ĐIỂM ĐÃ QUÉT ĐƯỢC:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildScannedScoreTable(),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  // Handle the submit button press event
                  Navigator.pushNamed(context, RouteManager.comparison);
                },
                child: const Text(
                  'TIẾP TỤC',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildScannedScoreTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        5: FixedColumnWidth(100.0),
      },
      children: [
        TableRow(
          children: [
            _buildTableHeaderCell('STT'),
            _buildTableHeaderCell('Mã SV'),
            _buildTableHeaderCell('Họ SV'),
            _buildTableHeaderCell('Tên SV'),
            _buildTableHeaderCell('Mã lớp'),
            _buildTableHeaderCell('Điểm'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('1'),
            _buildTableCell('12345'),
            _buildTableCell('Nguyen Van', alignLeft: true),
            _buildTableCell('A', alignLeft: true),
            _buildTableCell('ABC123'),
            _buildTableCell('10.0'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('2'),
            _buildTableCell('67890'),
            _buildTableCell('Tran Thi', alignLeft: true),
            _buildTableCell('B', alignLeft: true),
            _buildTableCell('DEF456'),
            _buildTableCell('7.0'),
          ],
        ),
        // Thêm các hàng khác tương tự ở đây
      ],
    );
  }

  Widget _buildTableHeaderCell(String value) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String value, {bool alignLeft = false}) {
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
}
