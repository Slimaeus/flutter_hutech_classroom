import 'package:flutter_hutech_classroom/models/post.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = PostStoreBase with _$PostStore;

abstract class PostStoreBase extends EntityStoreBase<String, Post>
    with Store, BaseStoreMixin {
  PostStoreBase()
      : super(
            entityRoute: "Posts",
            initItem: Post(),
            fromJson: Post.fromJson,
            updateWithFormValues: (entity, formValues) => Post(
                id: formValues.id ?? entity.id,
                classroom: formValues.classroom ?? entity.classroom,
                content: formValues.content ?? entity.content,
                createDate: formValues.createDate ?? entity.createDate,
                link: formValues.link ?? entity.link,
                user: formValues.user ?? entity.user));

  Future<bool> fetchClassroomPostList(String classroomId) async {
    isListFetching = true;
    var response = await apiService
        .get<List<Post>>('v1/Classrooms/$classroomId/$entityRoute', (results) {
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
