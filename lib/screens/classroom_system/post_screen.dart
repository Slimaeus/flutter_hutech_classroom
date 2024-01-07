import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/models/post.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/post_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ClassroomStore classroomStore;
  late PostStore postStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    classroomStore = context.read<ClassroomStore>();
    classroomStore.onInit(context);

    postStore = context.read<PostStore>();
    postStore.onInit(context);
    postStore
        .fetchClassroomPostList(classroomStore.selectedClassroom.id!)
        .then((isSuccess) {
      // print('Posts: ${postStore.items.length}');
    });
  }

  String formattedDate(DateTime date) {
    final formatter = DateFormat('HH:mm:ss - dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
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
          return ListView.builder(
            itemCount: postStore.items.length,
            itemBuilder: (context, index) {
              final Post post = postStore.items[index];
              return GestureDetector(
                onTap: () {
                  // TODO: Chuyển hướng đến màn hình chi tiết bài đăng
                },
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    '${post.user?.lastName ?? ''} ${post.user?.firstName ?? ''}',
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
                              const SizedBox(height: 4),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Html(data: post.content ?? ''),
                              const SizedBox(height: 8),
                              if (post.link != null && post.link!.trim() != "")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Đường dẫn đính kèm:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
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
                                                            color: Colors.blue,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
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
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteManager.exercise);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
          );
        }),
      ),
    );
  }
}
