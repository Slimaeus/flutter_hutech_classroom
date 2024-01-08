import 'package:flutter_hutech_classroom/models/exercise.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:flutter_hutech_classroom/stores/entity_store_mixin.dart';
import 'package:mobx/mobx.dart';

part 'exercise_store.g.dart';

class ExerciseStore = ExerciseStoreBase with _$ExerciseStore;

abstract class ExerciseStoreBase extends EntityStoreBase<String, Exercise>
    with Store, BaseStoreMixin, EntityStoreMixin<String, Exercise> {
  ExerciseStoreBase()
      : super(
            entityRoute: "Exercises",
            fromJson: Exercise.fromJson,
            updateWithFormValues: (entity, formValues) => Exercise(
                id: formValues.id ?? entity.id,
                classroom: formValues.classroom ?? entity.classroom,
                createDate: formValues.createDate ?? entity.createDate,
                criteria: formValues.criteria ?? entity.criteria,
                deadline: formValues.deadline ?? entity.deadline,
                instruction: formValues.instruction ?? entity.instruction,
                link: formValues.link ?? entity.link,
                title: formValues.title ?? entity.title,
                topic: formValues.topic ?? entity.topic,
                totalScore: formValues.totalScore ?? entity.totalScore));

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
  ObservableList<Exercise> items = ObservableList();

  @observable
  Exercise selectedItem = Exercise();

  @override
  void setSelectedItem(Exercise value) {
    selectedItem = value;
  }

  @override
  void setItems(List<Exercise> value) {
    items = ObservableList.of(value);
  }

  @override
  @action
  Future<bool> fetchList() async {
    isListFetching = true;
    var response =
        await apiService.get<List<Exercise>>('v1/$entityRoute', (results) {
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
        await apiService.get<Exercise>('v1/$entityRoute/$id', (results) {
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
  createItem(Exercise item) {
    items.insert(0, item);
  }

  @override
  @action
  Future<bool> create(Map<String, dynamic> formValues) async {
    isCreating = true;
    var response =
        await apiService.post<Exercise>('v1/$entityRoute', (results) {
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
  updateItem(String id, Exercise formValues) {
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
  Future<bool> update(String id, Exercise formValues) async {
    isUpdating = true;
    var response =
        await apiService.put<Exercise>('v1/$entityRoute/$id', (results) {
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
        await apiService.delete<Exercise>('v1/$entityRoute/$id', (results) {
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

  Future<bool> fetchClassroomExerciseList(String classroomId) async {
    isListFetching = true;
    var response = await apiService.get<List<Exercise>>(
        'v1/Classrooms/$classroomId/$entityRoute', (results) {
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
