import 'package:flutter_hutech_classroom/models/group.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:flutter_hutech_classroom/stores/entity_store_mixin.dart';
import 'package:mobx/mobx.dart';

part 'group_store.g.dart';

class GroupStore = GroupStoreBase with _$GroupStore;

abstract class GroupStoreBase extends EntityStoreBase<String, Group>
    with Store, BaseStoreMixin, EntityStoreMixin<String, Group> {
  GroupStoreBase()
      : super(
            entityRoute: "Groups",
            fromJson: Group.fromJson,
            updateWithFormValues: (entity, formValues) => Group(
                id: formValues.id ?? entity.id,
                name: formValues.name ?? entity.name,
                description: formValues.description ?? entity.description,
                createDate: formValues.createDate ?? entity.createDate,
                classroom: formValues.classroom ?? entity.classroom,
                leader: formValues.leader ?? entity.leader));

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
  ObservableList<Group> items = ObservableList();

  @observable
  Group selectedItem = Group();

  @override
  void setSelectedItem(Group value) {
    selectedItem = value;
  }

  @override
  void setItems(List<Group> value) {
    items = ObservableList.of(value);
  }

  @override
  @action
  Future<bool> fetchList() async {
    isListFetching = true;
    var response =
        await apiService.get<List<Group>>('v1/$entityRoute', (results) {
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
        await apiService.get<Group>('v1/$entityRoute/$id', (results) {
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
  createItem(Group item) {
    items.insert(0, item);
  }

  @override
  @action
  Future<bool> create(Map<String, dynamic> formValues) async {
    isCreating = true;
    var response = await apiService.post<Group>('v1/$entityRoute', (results) {
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
  updateItem(String id, Group formValues) {
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
  Future<bool> update(String id, Group formValues) async {
    isUpdating = true;
    var response =
        await apiService.put<Group>('v1/$entityRoute/$id', (results) {
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
        await apiService.delete<Group>('v1/$entityRoute/$id', (results) {
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

  @action
  Future<bool> fetchClassroomGroupList(String classroomId) async {
    isListFetching = true;
    var response = await apiService
        .get<List<Group>>('v1/Classrooms/$classroomId/$entityRoute', (results) {
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
