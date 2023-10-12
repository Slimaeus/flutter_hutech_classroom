import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");

  @observable
  User user = User();

  @action
  Future<void> login(String userName, String password) async {
    var result = await _apiService.post<User>(
        "v1/Account/login",
        (json) => User.fromJson(json),
        {'userName': userName, 'password': password});
    if (result.isSucceed && result.data != null) {
      user = result.data as User;
    }
  }

  @action
  void resetValue() {
    user = User();
  }
}
