import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/comment.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/comment_store.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import 'package:signalr_netcore/signalr_client.dart';

part 'comment_socket_store.g.dart';

class CommentSocketStore = CommonSocketStoreBase with _$CommentSocketStore;

abstract class CommonSocketStoreBase extends BaseStore
    with Store, BaseStoreMixin {
  late UserStore userStore;
  late CommentStore commentStore;
  late CommonStore commonStore;
  late HubConnection connection;

  createConnection(String postId, {int? pageNumber, int? pageSize}) {
    String paramsString = '&pageNumber=1&pageSize=100';
    if (pageNumber != null &&
        pageSize != null &&
        pageNumber != 0 &&
        pageSize > 1) {
      paramsString = '&pageNumber=$pageNumber&pageSize=$pageSize';
    }
    connection = HubConnectionBuilder()
        .withUrl(
            'https://hutechclassroom.azurewebsites.net/hubs/comments?postId=$postId$paramsString',
            options: HttpConnectionOptions(
                skipNegotiation: true,
                transport: HttpTransportType.WebSockets,
                accessTokenFactory: () async {
                  return commonStore.jwt ?? '';
                }))
        .withAutomaticReconnect()
        .build();

    connection.start()!.catchError((error) =>
        developer.log('Error establishing the connection: ', error: error));

    connection.on('LoadComments', _handleLoadComments);
    connection.on('ReceiveComment', _handleReceiveComment);
    connection.on('DeleteComment', _handleDeleteComment);
  }

  @action
  void _handleLoadComments(List<Object?>? args) {
    List<Comment> comments =
        (args![0] as List<dynamic>).map((e) => Comment.fromJson(e!)).toList();
    commentStore.setItems(comments);
  }

  @action
  void _handleReceiveComment(List<Object?>? args) {
    Comment comment = Comment.fromJson(args![0] as dynamic);
    commentStore.setItems([comment, ...commentStore.items]);
  }

  @action
  void _handleDeleteComment(List<Object?>? args) {
    Comment comment = Comment.fromJson(args![0] as dynamic);
    commentStore.setItems(
        [...commentStore.items.where((element) => element.id != comment.id)]);
  }

  stopConnection() {
    connection.stop().catchError(
        (error) => developer.log('Error stopping connection: ', error: error));
  }

  clearComments() {
    commentStore.setItems([]);
    stopConnection();
  }

  Future addComment(Comment values, String postId) async {
    Map<String, String?> formValues = {
      'content': values.content,
      'postId': postId,
      'userId': userStore.user.id
    };
    try {
      await connection.invoke('SendComment', args: [formValues]);
    } catch (error) {
      developer.log('Error when adding comment', error: error);
    }
  }

  deleteComment(String id) async {
    try {
      await connection.invoke('DeleteComment', args: [
        {'id': id}
      ]);
    } catch (error) {
      developer.log('Error when deleting comment', error: error);
    }
  }

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    userStore = context.read<UserStore>();
    commonStore = context.read<CommonStore>();
    commentStore = context.read<CommentStore>();
  }
}
