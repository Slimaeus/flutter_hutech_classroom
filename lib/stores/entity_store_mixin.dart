import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/entity_form_values.dart';
import 'package:mobx/mobx.dart';

mixin EntityStoreMixin<TId, TEntity extends EntityFormValues<TId>> on Store {
  @protected
  void setSelectedItem(TEntity value);

  @protected
  void setItems(List<TEntity> value);

  // bool isListFetching = false;
  // bool isDetailsFetching = false;
  // bool isCreating = false;
  // bool isUpdating = false;
  // bool isDeleteing = false;

  // ObservableList<TEntity> items = ObservableList();

  // late TEntity selectedItem;

  Future<bool> fetchList();

  Future<bool> fetchItem(TId id);

  createItem(TEntity item);

  Future<bool> create(TEntity formValues);

  updateItem(TId id, TEntity formValues);

  Future<bool> update(TId id, TEntity formValues);

  deleteItem(TId id);

  Future<bool> delete(TId id);
}
