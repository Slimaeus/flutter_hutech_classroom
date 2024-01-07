import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/entity_store_mixin.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:provider/provider.dart';

abstract class EntityStoreBase<TId, TEntity extends EntityFormValues<TId>>
    extends BaseStore with Store, BaseStoreMixin, EntityStoreMixin<TEntity> {
  final ApiService apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore commonStore;
  final String entityRoute;
  final TEntity initItem;
  final TEntity Function(Map<String, dynamic> json) fromJson;
  EntityStoreBase(
      {required this.entityRoute,
      required this.initItem,
      required this.fromJson}) {
    seletedItem = initItem;
  }

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
  ObservableList<TEntity> items = ObservableList();

  @observable
  late TEntity seletedItem;

  @override
  void setSelected(TEntity value) {
    this.seletedItem = value;
  }

  @action
  Future<bool> fetchList() async {
    isListFetching = true;
    var response =
        await apiService.get<List<TEntity>>('v1/$entityRoute', (results) {
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

  @action
  Future<bool> fetchItem(TId id) async {
    isDetailsFetching = true;
    var response =
        await apiService.get<TEntity>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setSelected(response.data!);
      isDetailsFetching = false;
      return true;
    }
    isDetailsFetching = false;
    return false;
  }

  @action
  Future<bool> create(TEntity formValues) async {
    isCreating = true;
    var response = await apiService.post<TEntity>('v1/$entityRoute', (results) {
      return fromJson(results);
    }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      setSelected(response.data!);
      isCreating = false;
      return true;
    }
    isCreating = false;
    return false;
  }

  @action
  Future<bool> update(TId id, TEntity formValues) async {
    isUpdating = true;
    var response =
        await apiService.put<TEntity>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, formValues, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      isUpdating = false;
      return true;
    }
    isUpdating = false;
    return false;
  }

  @action
  Future<bool> delete(TId id) async {
    isDeleteing = true;
    var response =
        await apiService.delete<TEntity>('v1/$entityRoute/$id', (results) {
      return fromJson(results);
    }, headers: {'Authorization': 'Bearer ${commonStore.jwt}'});
    if (response.isSucceed && response.data != null) {
      isDeleteing = false;
      return true;
    }
    isDeleteing = false;
    return false;
  }

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    commonStore = context.read<CommonStore>();
  }
}
