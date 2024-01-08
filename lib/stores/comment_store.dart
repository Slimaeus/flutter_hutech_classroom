import 'package:flutter_hutech_classroom/models/comment.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:flutter_hutech_classroom/stores/entity_store_mixin.dart';
import 'package:mobx/mobx.dart';

part 'comment_store.g.dart';

class CommentStore = CommentStoreBase with _$CommentStore;

abstract class CommentStoreBase extends EntityStoreBase<String, Comment>
    with Store, BaseStoreMixin, EntityStoreMixin<String, Comment> {
  CommentStoreBase()
      : super(
            entityRoute: "Comments",
            fromJson: Comment.fromJson,
            updateWithFormValues: (entity, formValues) => Comment(
                id: formValues.id ?? entity.id,
                content: formValues.content ?? entity.content,
                post: formValues.post ?? entity.post,
                createDate: formValues.createDate ?? entity.createDate,
                user: formValues.user ?? entity.user));

  @observable
  bool isListFetching = false;
  @observable
  bool isDetailsFetching = false;
  @observable
  bool isCreating = false;
  @observable
  bool isUpdating = false;
  @observable
  bool isDeleteing = false;

  @observable
  ObservableList<Comment> items = ObservableList();

  @observable
  Comment selectedItem = Comment();

  @override
  void setSelectedItem(Comment value) {
    selectedItem = value;
  }

  @override
  void setItems(List<Comment> value) {
    items = ObservableList.of(value);
  }

  @override
  @action
  Future<bool> fetchList() async {
    isListFetching = true;
    var response =
        await apiService.get<List<Comment>>('v1/$entityRoute', (results) {
      return (results as List).map((c) => fromJson(c)).toList();
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setItems(response.data!);
      isListFetching = false;
      return true;
    }
    isListFetching = false;
    return false;
  }

  @override
  @action
  Future<bool> fetchItem(String id) async {
    isDetailsFetching = true;
    var response =
        await apiService.get<Comment>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setSelectedItem(response.data!);
      isDetailsFetching = false;
      return true;
    }
    isDetailsFetching = false;
    return false;
  }

  @override
  @action
  createItem(Comment item) {
    items.insert(0, item);
  }

  @override
  @action
  Future<bool> create(Map<String, dynamic> formValues) async {
    isCreating = true;
    var response = await apiService.post<Comment>('v1/$entityRoute', (results) {
      return fromJson(results);
    }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setSelectedItem(response.data!);
      createItem(response.data!);
      isCreating = false;
      return true;
    }
    isCreating = false;
    return false;
  }

  @override
  @action
  updateItem(String id, Comment formValues) {
    if (selectedItem.id != null || selectedItem.id != '') {
      if (id == selectedItem.id) {
        selectedItem = updateWithFormValues(selectedItem, formValues);
      }
    }
    int index = items.indexWhere((e) => e.id == id);
    if (index != -1) {
      items[index] = updateWithFormValues(items[index], formValues);
    }
  }

  @override
  @action
  Future<bool> update(String id, Comment formValues) async {
    isUpdating = true;
    var response =
        await apiService.put<Comment>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      updateItem(id, formValues);
      isUpdating = false;
      return true;
    }
    isUpdating = false;
    return false;
  }

  @override
  @action
  deleteItem(String id) {
    int itemIndex = items.indexWhere((item) => item.id == id);
    items.removeAt(itemIndex);
  }

  @override
  @action
  Future<bool> delete(String id) async {
    isDeleteing = true;
    var response =
        await apiService.delete<Comment>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      deleteItem(id);
      isDeleteing = false;
      return true;
    }
    isDeleteing = false;
    return false;
  }

  Future<bool> fetchCommentCommentList(String postId) async {
    isListFetching = true;
    var response = await apiService
        .get<List<Comment>>('v1/Comments/$postId/$entityRoute', (results) {
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
