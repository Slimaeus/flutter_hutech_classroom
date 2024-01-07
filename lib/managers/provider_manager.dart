import 'package:flutter_hutech_classroom/stores/classroom_store.dart';
import 'package:flutter_hutech_classroom/stores/comment_socket_store.dart';
import 'package:flutter_hutech_classroom/stores/comment_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/exercise_store.dart';
import 'package:flutter_hutech_classroom/stores/post_store.dart';
import 'package:flutter_hutech_classroom/stores/result_store.dart';
import 'package:flutter_hutech_classroom/stores/score_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderManager {
  ProviderManager._();

  static List<SingleChildWidget> providers = [
    Provider(
      create: (_) => UserStore(),
    ),
    Provider(create: (_) => CommonStore()),
    Provider(create: (_) => ResultStore()),
    Provider(create: (_) => ClassroomStore()),
    Provider(create: (_) => ScoreStore()),
    Provider(create: (_) => PostStore()),
    Provider(create: (_) => ExerciseStore()),
    Provider(create: (_) => CommentStore()),
    Provider(create: (_) => CommentSocketStore()),
  ];
}
