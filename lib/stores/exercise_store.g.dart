// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExerciseStore on ExerciseStoreBase, Store {
  late final _$isListFetchingAtom =
      Atom(name: 'ExerciseStoreBase.isListFetching', context: context);

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
      Atom(name: 'ExerciseStoreBase.isDetailsFetching', context: context);

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
      Atom(name: 'ExerciseStoreBase.isCreating', context: context);

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
      Atom(name: 'ExerciseStoreBase.isUpdating', context: context);

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
      Atom(name: 'ExerciseStoreBase.isDeleteing', context: context);

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

  late final _$itemsAtom =
      Atom(name: 'ExerciseStoreBase.items', context: context);

  @override
  ObservableList<Exercise> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Exercise> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$selectedItemAtom =
      Atom(name: 'ExerciseStoreBase.selectedItem', context: context);

  @override
  Exercise get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Exercise value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  late final _$fetchListAsyncAction =
      AsyncAction('ExerciseStoreBase.fetchList', context: context);

  @override
  Future<bool> fetchList() {
    return _$fetchListAsyncAction.run(() => super.fetchList());
  }

  late final _$fetchItemAsyncAction =
      AsyncAction('ExerciseStoreBase.fetchItem', context: context);

  @override
  Future<bool> fetchItem(String id) {
    return _$fetchItemAsyncAction.run(() => super.fetchItem(id));
  }

  late final _$createAsyncAction =
      AsyncAction('ExerciseStoreBase.create', context: context);

  @override
  Future<bool> create(Map<String, dynamic> formValues) {
    return _$createAsyncAction.run(() => super.create(formValues));
  }

  late final _$updateAsyncAction =
      AsyncAction('ExerciseStoreBase.update', context: context);

  @override
  Future<bool> update(String id, Exercise formValues) {
    return _$updateAsyncAction.run(() => super.update(id, formValues));
  }

  late final _$deleteAsyncAction =
      AsyncAction('ExerciseStoreBase.delete', context: context);

  @override
  Future<bool> delete(String id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$ExerciseStoreBaseActionController =
      ActionController(name: 'ExerciseStoreBase', context: context);

  @override
  dynamic createItem(Exercise item) {
    final _$actionInfo = _$ExerciseStoreBaseActionController.startAction(
        name: 'ExerciseStoreBase.createItem');
    try {
      return super.createItem(item);
    } finally {
      _$ExerciseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateItem(String id, Exercise formValues) {
    final _$actionInfo = _$ExerciseStoreBaseActionController.startAction(
        name: 'ExerciseStoreBase.updateItem');
    try {
      return super.updateItem(id, formValues);
    } finally {
      _$ExerciseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteItem(String id) {
    final _$actionInfo = _$ExerciseStoreBaseActionController.startAction(
        name: 'ExerciseStoreBase.deleteItem');
    try {
      return super.deleteItem(id);
    } finally {
      _$ExerciseStoreBaseActionController.endAction(_$actionInfo);
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
