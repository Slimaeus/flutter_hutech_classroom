import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/exercise_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_hutech_classroom/models/exercise.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ClassroomStore classroomStore;
  late ExerciseStore exerciseStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);

    exerciseStore = context.read<ExerciseStore>();
    exerciseStore.onInit(context);
    exerciseStore
        .fetchClassroomExerciseList(classroomStore.selectedClassroom.id!)
        .then((isSuccess) {
      // print('Exercises: ${exerciseStore.items.length}');
      // commentSocketStore.createConnection(exerciseStore.items[1].id!);
    });
  }

  String formattedDate(DateTime date) {
    final formatter = DateFormat('HH:mm:ss - dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
  }

  // Hàm để hiển thị dialog xem chi tiết bài tập
  Future<void> _showExerciseDetailsModal(Exercise exercise) async {
    // TODO: Thêm logic để xem chi tiết bài tập (nếu cần)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: widget.title, hasLeading: true),
      endDrawer: customDrawer(context),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: exerciseStore.items.length,
                  itemBuilder: (context, index) {
                    final Exercise exercise = exerciseStore.items[index];
                    return GestureDetector(
                      onTap: () {
                        _showExerciseDetailsModal(exercise);
                      },
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Phần tiêu đề và ngày tạo
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${exercise.title}${exercise.topic != null ? ' - Chủ đề: ${exercise.topic}' : ''}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Xoá'),
                                            ),
                                            const PopupMenuItem(
                                              value: 'viewDetail',
                                              child: Text('Xem Chi Tiết'),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              // TODO: Xử lý logic khi bấm nút Xoá
                                            } else if (value == 'viewDetail') {
                                              // TODO: Xử lý logic khi bấm nút Xem Chi Tiết
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      exercise.createDate != null
                                          ? formattedDate(DateTime.parse(
                                                  '${exercise.createDate!.toIso8601String()}Z')
                                              .toLocal())
                                          : 'Ngày tạo không xác định',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              // Phần tổng điểm và thời hạn
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tổng điểm: ${exercise.totalScore}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Text("Thời hạn: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          exercise.deadline != null
                                              ? formattedDate(DateTime.parse(
                                                      '${exercise.deadline!.toIso8601String()}Z')
                                                  .toLocal())
                                              : 'Ngày tạo không xác định',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                              // Phần hướng dẫn
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hướng dẫn:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Html(data: exercise.instruction ?? ''),
                                  ],
                                ),
                              ),
                              // Phần đường dẫn
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (exercise.link != null &&
                                        exercise.link!.trim() != "")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                'Đường dẫn đính kèm:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: exercise.link!
                                                .trim()
                                                .split(RegExp(r'\s+'))
                                                .map((link) => ListTile(
                                                      title: link.startsWith(
                                                                  'https://') ||
                                                              link.startsWith(
                                                                  'http://')
                                                          ? Text(
                                                              link,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            )
                                                          : Text(link),
                                                    ))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              // Phần tiêu chí chấm điểm
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tiêu chí chấm điểm:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Html(data: exercise.criteria ?? ''),
                                  ],
                                ),
                              ),
                              const Divider(),
                              // Phần Xem Chi Tiết
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Nút Xem Chi Tiết
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Chuyển hướng đến màn hình chi tiết bài tập
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.info),
                                          SizedBox(width: 8),
                                          Text(
                                            'Xem Chi Tiết',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Nút Kết Quả
                                    ElevatedButton(
                                      onPressed: () {
                                        // TODO: Chuyển hướng đến màn hình kết quả
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0), 
                                        ),
                                      ),
                                      child: const Text('KẾT QUẢ'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
