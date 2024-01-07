import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:provider/provider.dart';

abstract class EntityStoreBase<TId, TEntity extends EntityFormValues<TId>>
    extends BaseStore with Store, BaseStoreMixin {
  final ApiService apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore commonStore;
  final String entityRoute;
  final TEntity Function(Map<String, dynamic> json) fromJson;
  final TEntity Function(TEntity entity, TEntity formValues)
      updateWithFormValues;
  EntityStoreBase(
      {required this.entityRoute,
      required this.fromJson,
      required this.updateWithFormValues});

  // @observable
  // bool isListFetching = false;
  // @observable
  // bool isDetailsFetching = false;
  // @observable
  // bool isCreating = false;
  // @observable
  // bool isUpdating = false;
  // @observable
  // bool isDeleteing = false;

  // @observable
  // ObservableList<TEntity> items = ObservableList();

  // @observable
  // late TEntity selectedItem;

  // void setSelectedItem(TEntity value) {
  //   this.selectedItem = value;
  // }

  // void setItems(List<TEntity> value) {
  //   this.items = ObservableList.of(value);
  // }

  // @action
  // Future<bool> fetchList() async {
  //   isListFetching = true;
  //   var response =
  //       await apiService.get<List<TEntity>>('v1/$entityRoute', (results) {
  //     return (results as List).map((c) => fromJson(c)).toList();
  //   }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
  //   if (response.isSucceed && response.data != null) {
  //     setItems(response.data!);
  //     isListFetching = false;
  //     return true;
  //   }
  //   isListFetching = false;
  //   return false;
  // }

  // @action
  // Future<bool> fetchItem(TId id) async {
  //   isDetailsFetching = true;
  //   var response =
  //       await apiService.get<TEntity>('v1/$entityRoute/$id', (results) {
  //     return fromJson(results);
  //   }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
  //   if (response.isSucceed && response.data != null) {
  //     setSelectedItem(response.data!);
  //     isDetailsFetching = false;
  //     return true;
  //   }
  //   isDetailsFetching = false;
  //   return false;
  // }

  // @action
  // createItem(TEntity item) {
  //   items.insert(0, item);
  // }

  // @action
  // Future<bool> create(TEntity formValues) async {
  //   isCreating = true;
  //   var response = await apiService.post<TEntity>('v1/$entityRoute', (results) {
  //     return fromJson(results);
  //   }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
  //   if (response.isSucceed && response.data != null) {
  //     setSelectedItem(response.data!);
  //     createItem(response.data!);
  //     isCreating = false;
  //     return true;
  //   }
  //   isCreating = false;
  //   return false;
  // }

  // @action
  // updateItem(TId id, TEntity formValues) {
  //   if (selectedItem.id != null || selectedItem.id != '') {
  //     if (id == selectedItem.id) {
  //       selectedItem = updateWithFormValues(selectedItem, formValues);
  //     }
  //   }
  //   int index = items.indexWhere((e) => e.id == id);
  //   if (index != -1) {
  //     items[index] = updateWithFormValues(items[index], formValues);
  //   }
  // }

  // @action
  // Future<bool> update(TId id, TEntity formValues) async {
  //   isUpdating = true;
  //   var response =
  //       await apiService.put<TEntity>('v1/$entityRoute/$id', (results) {
  //     return fromJson(results);
  //   }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
  //   if (response.isSucceed && response.data != null) {
  //     updateItem(id, formValues);
  //     isUpdating = false;
  //     return true;
  //   }
  //   isUpdating = false;
  //   return false;
  // }

  // @action
  // deleteItem(TId id) {
  //   int itemIndex = items.indexWhere((item) => item.id == id);
  //   items.removeAt(itemIndex);
  // }

  // @action
  // Future<bool> delete(TId id) async {
  //   isDeleteing = true;
  //   var response =
  //       await apiService.delete<TEntity>('v1/$entityRoute/$id', (results) {
  //     return fromJson(results);
  //   }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
  //   if (response.isSucceed && response.data != null) {
  //     deleteItem(id);
  //     isDeleteing = false;
  //     return true;
  //   }
  //   isDeleteing = false;
  //   return false;
  // }

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    commonStore = context.read<CommonStore>();
  }
}
