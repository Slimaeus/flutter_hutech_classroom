import 'package:flutter_hutech_classroom/models/comment.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:mobx/mobx.dart';

part 'comment_store.g.dart';

class CommentStore = CommentStoreBase with _$CommentStore;

abstract class CommentStoreBase extends EntityStoreBase<String, Comment>
    with Store, BaseStoreMixin {
  CommentStoreBase()
      : super(
            entityRoute: "Comments",
            initItem: Comment(),
            fromJson: Comment.fromJson,
            updateWithFormValues: (entity, formValues) => Comment(
                id: formValues.id ?? entity.id,
                content: formValues.content ?? entity.content,
                post: formValues.post ?? entity.post,
                createDate: formValues.createDate ?? entity.createDate,
                user: formValues.user ?? entity.user));

  Future<bool> fetchPostCommentList(String postId) async {
    isListFetching = true;
    var response = await apiService
        .get<List<Comment>>('v1/Posts/$postId/$entityRoute', (results) {
      return (results as List).map((c) => fromJson(c)).toList();
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      items = ObservableList.of(response.data!);
      isListFetching = false;
      return true;
    }
    isListFetching = false;
    return false;
  }
}
