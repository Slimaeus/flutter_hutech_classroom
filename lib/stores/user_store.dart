import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  User user = User();

  @action
  Future<void> login() async {
    user = User(
        id: 'id',
        firstName: 'Nguyen',
        lastName: 'Thai',
        userName: '2080600914');
  }

  @action
  void resetValue() {
    user = User();
  }
}
