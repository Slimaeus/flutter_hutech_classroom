import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/models/user.dart';
import 'package:flutter_hutech_classroom/services/api_service.dart';
import 'package:flutter_hutech_classroom/stores/base_store.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase extends BaseStore with Store, BaseStoreMixin {
  final ApiService _apiService =
      ApiService("https://hutechclassroom.azurewebsites.net/api/");
  late CommonStore _commonStore;

  @observable
  bool isLoggingIn = false;

  @observable
  User user = User();

  @action
  Future<bool> getCurrentUser() async {
    isLoggingIn = true;
    var result = await _apiService.get<User>(
        "v1/Account/@me", (json) => User.fromJson(json),
        headers: {'Authorization': 'Bearer ${_commonStore.jwt}'});
    if (result.isSucceed && result.data != null) {
      user = result.data as User;
      await _commonStore.setToken(user.token!);
      isLoggingIn = false;
      return true;
    }
    isLoggingIn = false;
    return false;
  }

  @action
  Future<bool> login(String userName, String password) async {
    isLoggingIn = true;
    var result = await _apiService.post<User>(
        "v1/Account/login",
        (json) => User.fromJson(json),
        {'userName': userName, 'password': password});
    if (result.isSucceed && result.data != null) {
      user = result.data as User;
      await _commonStore.setToken(user.token!);
      isLoggingIn = false;
      return true;
    }
    isLoggingIn = false;
    return false;
  }

  @override
  void onInit(BuildContext context) {
    _commonStore = context.read<CommonStore>();
  }

  @action
  Future logout() async {
    await _commonStore.removeToken();
    user = User();
  }

  @override
  void resetValue() {
    user = User();
  }
}
