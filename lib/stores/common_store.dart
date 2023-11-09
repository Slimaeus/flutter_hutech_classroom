import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

part 'common_store.g.dart';

class CommonStore = CommonStoreBase with _$CommonStore;

abstract class CommonStoreBase with Store {
  final _storage = const FlutterSecureStorage();
  static const _jwtKey = "jwt";

  @observable
  String? _jwt;

  @computed
  String? get jwt => _jwt;

  @computed
  bool get hasToken => jwt != null;

  @action
  Future loadToken() async {
    _jwt = await _storage.read(key: _jwtKey);
  }

  @action
  Future setToken(String token) async {
    await _storage.write(key: _jwtKey, value: token);
    _jwt = token;
  }

  @action
  Future removeToken() async {
    await _storage.delete(key: _jwtKey);
    _jwt = null;
  }
}
