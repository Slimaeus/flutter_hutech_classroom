import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");

  @observable
  bool isLoggingIn = false;

  @observable
  User user = User();

  @action
  Future<bool> login(String userName, String password) async {
    isLoggingIn = true;
    var result = await _apiService.post<User>(
        "v1/Account/login",
        (json) => User.fromJson(json),
        {'userName': userName, 'password': password});
    if (result.isSucceed && result.data != null) {
      user = result.data as User;
      isLoggingIn = false;
      return true;
    }
    isLoggingIn = false;
    return false;
  }

  @action
  void resetValue() {
    user = User();
  }
}
