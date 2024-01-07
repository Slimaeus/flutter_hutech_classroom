import 'package:flutter_hutech_classroom/models/exercise.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/entity_store.dart';
import 'package:mobx/mobx.dart';

part 'exercise_store.g.dart';

class ExerciseStore = ExerciseStoreBase with _$ExerciseStore;

abstract class ExerciseStoreBase extends EntityStoreBase<String, Exercise>
    with Store, BaseStoreMixin {
  ExerciseStoreBase()
      : super(
            entityRoute: "Exercises",
            initItem: Exercise(),
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
