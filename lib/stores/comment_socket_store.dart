import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/comment_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:provider/provider.dart';

abstract class CommenSocketStore extends BaseStore with Store, BaseStoreMixin {
  late CommentStore commentStore;

  

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    commentStore = context.read<CommentStore>();
  }
}
