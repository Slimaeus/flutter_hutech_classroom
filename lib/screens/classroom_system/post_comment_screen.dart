import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/comment_socket_store.dart';
import 'package:flutter_hutech_classroom/stores/comment_store.dart';
import 'package:flutter_hutech_classroom/stores/post_store.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_appbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_bottom_navigationbar.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class PostCommentScreen extends StatefulWidget {
  const PostCommentScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  late ClassroomStore classroomStore;
  late PostStore postStore;
  late CommentStore commentStore;
  late CommentSocketStore commentSocketStore;
  int _currentIndex = 0;
  TextEditingController commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

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
      commentSocketStore = context.read<CommentSocketStore>();
      commentSocketStore.onInit(context);
      commentSocketStore.createConnection(postStore.selectedItem.id!);
    });

    commentStore = context.read<CommentStore>();
    commentStore.onInit(context);

    commentController.addListener(() {
      setState(() {});
    });

    _commentFocusNode.addListener(() {
      if (!_commentFocusNode.hasFocus) {
        commentController.clear();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    commentSocketStore.clearComments();
  }

  String formattedDate(DateTime date) {
    final formatter = DateFormat('HH:mm:ss - dd/MM/yyyy', 'vi_VN');
    return formatter.format(date);
  }

  void _postComment() {
    // String commentText = commentController.text;
    // Handle posting logic here
    // ...
    // Clear the comment input field
    commentController.clear();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
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
                                      '${postStore.selectedItem.user?.lastName} ${postStore.selectedItem.user?.firstName}',
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
                                  postStore.selectedItem.createDate != null
                                      ? formattedDate(DateTime.parse(
                                              '${postStore.selectedItem.createDate!.toIso8601String()}Z')
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
                                Html(
                                    data: postStore.selectedItem.content ?? ''),
                                const SizedBox(height: 8),
                                if (postStore.selectedItem.link != null &&
                                    postStore.selectedItem.link!.trim() != "")
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        children: postStore.selectedItem.link!
                                            .trim()
                                            .split(RegExp(r'\s+'))
                                            .map((link) => ListTile(
                                                  title: link.startsWith(
                                                              'https://') ||
                                                          link.startsWith(
                                                              'http://')
                                                      ? Text(
                                                          link,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
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
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            focusNode: _commentFocusNode,
                            controller: commentController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Nhập nhận xét của bạn...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _postComment,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: const Text('TẠO'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Clear the comment input field
                                  commentController.clear();

                                  // Remove focus from the TextField to hide the keyboard
                                  _commentFocusNode.unfocus();
                                },
                                child: const Text('HUỶ'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Danh sách Nhận xét
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: commentStore.items.length,
                    itemBuilder: (context, index) {
                      final comment = commentStore.items[index];
                      return Card(
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
                                          '${comment.user?.lastName} ${comment.user?.firstName}',
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
                                          ],
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              // TODO: Xử lý logic khi bấm nút Xoá
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      comment.createDate != null
                                          ? formattedDate(DateTime.parse(
                                                  '${comment.createDate!.toIso8601String()}Z')
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
                                child: Html(data: comment.content ?? ''),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
