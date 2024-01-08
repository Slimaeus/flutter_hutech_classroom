// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupStore on GroupStoreBase, Store {
  late final _$isListFetchingAtom =
      Atom(name: 'GroupStoreBase.isListFetching', context: context);

  @override
  bool get isListFetching {
    _$isListFetchingAtom.reportRead();
    return super.isListFetching;
  }

  @override
  set isListFetching(bool value) {
    _$isListFetchingAtom.reportWrite(value, super.isListFetching, () {
      super.isListFetching = value;
    });
  }

  late final _$isDetailsFetchingAtom =
      Atom(name: 'GroupStoreBase.isDetailsFetching', context: context);

  @override
  bool get isDetailsFetching {
    _$isDetailsFetchingAtom.reportRead();
    return super.isDetailsFetching;
  }

  @override
  set isDetailsFetching(bool value) {
    _$isDetailsFetchingAtom.reportWrite(value, super.isDetailsFetching, () {
      super.isDetailsFetching = value;
    });
  }

  late final _$isCreatingAtom =
      Atom(name: 'GroupStoreBase.isCreating', context: context);

  @override
  bool get isCreating {
    _$isCreatingAtom.reportRead();
    return super.isCreating;
  }

  @override
  set isCreating(bool value) {
    _$isCreatingAtom.reportWrite(value, super.isCreating, () {
      super.isCreating = value;
    });
  }

  late final _$isUpdatingAtom =
      Atom(name: 'GroupStoreBase.isUpdating', context: context);

  @override
  bool get isUpdating {
    _$isUpdatingAtom.reportRead();
    return super.isUpdating;
  }

  @override
  set isUpdating(bool value) {
    _$isUpdatingAtom.reportWrite(value, super.isUpdating, () {
      super.isUpdating = value;
    });
  }

  late final _$isDeleteingAtom =
      Atom(name: 'GroupStoreBase.isDeleteing', context: context);

  @override
  bool get isDeleteing {
    _$isDeleteingAtom.reportRead();
    return super.isDeleteing;
  }

  @override
  set isDeleteing(bool value) {
    _$isDeleteingAtom.reportWrite(value, super.isDeleteing, () {
      super.isDeleteing = value;
    });
  }

  late final _$itemsAtom = Atom(name: 'GroupStoreBase.items', context: context);

  @override
  ObservableList<Group> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Group> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$selectedItemAtom =
      Atom(name: 'GroupStoreBase.selectedItem', context: context);

  @override
  Group get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Group value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  late final _$fetchListAsyncAction =
      AsyncAction('GroupStoreBase.fetchList', context: context);

  @override
  Future<bool> fetchList() {
    return _$fetchListAsyncAction.run(() => super.fetchList());
  }

  late final _$fetchItemAsyncAction =
      AsyncAction('GroupStoreBase.fetchItem', context: context);

  @override
  Future<bool> fetchItem(String id) {
    return _$fetchItemAsyncAction.run(() => super.fetchItem(id));
  }

  late final _$createAsyncAction =
      AsyncAction('GroupStoreBase.create', context: context);

  @override
  Future<bool> create(Map<String, dynamic> formValues) {
    return _$createAsyncAction.run(() => super.create(formValues));
  }

  late final _$updateAsyncAction =
      AsyncAction('GroupStoreBase.update', context: context);

  @override
  Future<bool> update(String id, Group formValues) {
    return _$updateAsyncAction.run(() => super.update(id, formValues));
  }

  late final _$deleteAsyncAction =
      AsyncAction('GroupStoreBase.delete', context: context);

  @override
  Future<bool> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$fetchClassroomGroupListAsyncAction =
      AsyncAction('GroupStoreBase.fetchClassroomGroupList', context: context);

  @override
  Future<bool> fetchClassroomGroupList(String classroomId) {
    return _$fetchClassroomGroupListAsyncAction
        .run(() => super.fetchClassroomGroupList(classroomId));
  }

  late final _$GroupStoreBaseActionController =
      ActionController(name: 'GroupStoreBase', context: context);

  @override
  dynamic createItem(Group item) {
    final _$actionInfo = _$GroupStoreBaseActionController.startAction(
        name: 'GroupStoreBase.createItem');
    try {
      return super.createItem(item);
    } finally {
      _$GroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateItem(String id, Group formValues) {
    final _$actionInfo = _$GroupStoreBaseActionController.startAction(
        name: 'GroupStoreBase.updateItem');
    try {
      return super.updateItem(id, formValues);
    } finally {
      _$GroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteItem(String id) {
    final _$actionInfo = _$GroupStoreBaseActionController.startAction(
        name: 'GroupStoreBase.deleteItem');
    try {
      return super.deleteItem(id);
    } finally {
      _$GroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isListFetching: ${isListFetching},
isDetailsFetching: ${isDetailsFetching},
isCreating: ${isCreating},
isUpdating: ${isUpdating},
isDeleteing: ${isDeleteing},
items: ${items},
selectedItem: ${selectedItem}
    ''';
  }
}