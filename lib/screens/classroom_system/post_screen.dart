import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/enums/classroom_type.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/classroom.dart';
import 'package:flutter_hutech_classroom/models/post.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/post_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_login_indicator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hutech_classroom/extensions/semester_extensions.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late UserStore userStore;
  late ClassroomStore classroomStore;
  late PostStore postStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    userStore = context.read<UserStore>();
    userStore.onInit(context);

    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);

    postStore = context.read<PostStore>();
    postStore.onInit(context);
    postStore
        .fetchClassroomPostList(classroomStore.selectedClassroom.id!)
        .then((isSuccess) {});
  }

  String formattedDate(DateTime date) {
    final formatter = DateFormat('HH:mm:ss - dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
  }

  Future<void> _showClassroomDetailsModal(Classroom classroom) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông tin lớp học',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mã môn: ${classroom.subject?.code}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Tên môn: ${classroom.subject?.title}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Số tín chỉ học phần: ${classroom.subject?.totalCredits}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Phòng: ${classroom.room}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Tên phòng: ${classroom.type == ClassroomType.theoryRoom ? "Phòng Lý Thuyết" : "Phòng Thực Hành"}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Thời gian học: ${classroom.studyPeriod}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Lớp: ${classroom.className}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Năm học: ${classroom.schoolYear}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Học kỳ: ${classroom.semester?.toText() ?? "Không có"}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Nhóm học: ${classroom.studyGroup}',
                  style: const TextStyle(fontSize: 16),
                ),
                if (classroom.practicalStudyGroup != null)
                  Text(
                    'Nhóm thực hành: ${classroom.practicalStudyGroup == "0" ? "Không có" : classroom.practicalStudyGroup}',
                    style: const TextStyle(fontSize: 16),
                  ),
                const Divider(),
                Text(
                  'Mã giảng viên: ${classroom.lecturer?.userName}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Tên giảng viên: ${classroom.lecturer?.lastName} ${classroom.lecturer?.firstName}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Divider(),
                Text(
                  'Khoa: ${classroom.faculty?.name}',
                  style: const TextStyle(fontSize: 16),
                ),
                // Text(
                //   'Ngành: ${classroom.subject?.major?.title}',
                //   style: const TextStyle(fontSize: 16),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hàm để hiển thị dialog tạo bài đăng
  Future<void> _showCreatePostDialog() async {
    TextEditingController contentController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tạo Bài Đăng'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: contentController,
                  minLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung',
                  ),
                  maxLines: 5,
                ),
                // Các trường dữ liệu khác của form tạo bài đăng (nếu có)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Xử lý logic để tạo bài đăng
                // Sử dụng contentController.text để lấy nội dung bài đăng
                // Đóng dialog sau khi xử lý thành công
                Map<String, dynamic> formValues = {
                  'content': contentController.text,
                  'classroomId': classroomStore.selectedClassroom.id,
                  'userId': userStore.user.id
                };
                postStore.create(formValues).then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Tạo'),
            ),
          ],
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog();
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (context) {
          return postStore.isListFetching
              ? customLoginIndicator(context)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
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
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: SizedBox(
                                height: 85,
                                width: double.infinity,
                                child: Image.asset(
                                  classroomStore.selectedClassroom.type ==
                                          ClassroomType.theoryRoom
                                      ? PathManager.banner1
                                      : classroomStore.selectedClassroom.type ==
                                              ClassroomType.practiceRoom
                                          ? PathManager.banner2
                                          : PathManager.banner3,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListTile(
                              title: Text(
                                classroomStore.selectedClassroom.title ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'GV. ${classroomStore.selectedClassroom.lecturer?.lastName ?? ''} ${classroomStore.selectedClassroom.lecturer?.firstName ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.info),
                                onPressed: () {
                                  _showClassroomDetailsModal(
                                      classroomStore.selectedClassroom);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: RefreshIndicator(
                        key: GlobalKey<RefreshIndicatorState>(),
                        onRefresh: () async {
                          await postStore.fetchClassroomPostList(
                              classroomStore.selectedClassroom.id!);
                        },
                        child: ListView.builder(
                          itemCount: postStore.items.length,
                          itemBuilder: (context, index) {
                            final Post post = postStore.items[index];
                            return GestureDetector(
                              onTap: () {
                                if (post.id == null) return;
                                postStore.fetchItem(post.id!).then((isSuccess) {
                                  Navigator.pushNamed(
                                      context, RouteManager.postComment);
                                });
                              },
                              child: Card(
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${post.user?.lastName ?? ''} ${post.user?.firstName ?? ''}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                PopupMenuButton(
                                                  itemBuilder: (context) => [
                                                    if (userStore.user.id ==
                                                        post.user?.id)
                                                      const PopupMenuItem(
                                                        value: 'delete',
                                                        child: Text('Xoá'),
                                                      ),
                                                    const PopupMenuItem(
                                                      value: 'viewDetail',
                                                      child:
                                                          Text('Xem Chi Tiết'),
                                                    ),
                                                  ],
                                                  onSelected: (value) {
                                                    if (value == 'delete') {
                                                      postStore
                                                          .delete(post.id!);
                                                    } else if (value ==
                                                        'viewDetail') {
                                                      postStore
                                                          .fetchItem(post.id!)
                                                          .then((isSuccess) {
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteManager
                                                                .postComment);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            Text(
                                              post.createDate != null
                                                  ? formattedDate(DateTime.parse(
                                                          '${post.createDate!.toIso8601String()}Z')
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Html(data: post.content ?? ''),
                                            const SizedBox(height: 8),
                                            if (post.link != null &&
                                                post.link!.trim() != "")
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Đường dẫn đính kèm:',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: post.link!
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
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontStyle:
                                                                              FontStyle.italic),
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
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            postStore
                                                .fetchItem(post.id!)
                                                .then((isSuccess) {
                                              Navigator.pushNamed(context,
                                                  RouteManager.postComment);
                                            });
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.comment),
                                              SizedBox(width: 8),
                                              Text(
                                                'Nhận Xét',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
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
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
