// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonStore on CommonStoreBase, Store {
  Computed<String?>? _$jwtComputed;

  @override
  String? get jwt => (_$jwtComputed ??=
          Computed<String?>(() => super.jwt, name: 'CommonStoreBase.jwt'))
      .value;
  Computed<bool>? _$hasTokenComputed;

  @override
  bool get hasToken =>
      (_$hasTokenComputed ??= Computed<bool>(() => super.hasToken,
              name: 'CommonStoreBase.hasToken'))
          .value;

  late final _$_jwtAtom = Atom(name: 'CommonStoreBase._jwt', context: context);

  @override
  String? get _jwt {
    _$_jwtAtom.reportRead();
    return super._jwt;
  }

  @override
  set _jwt(String? value) {
    _$_jwtAtom.reportWrite(value, super._jwt, () {
      super._jwt = value;
    });
  }

  late final _$loadTokenAsyncAction =
      AsyncAction('CommonStoreBase.loadToken', context: context);

  @override
  Future<dynamic> loadToken() {
    return _$loadTokenAsyncAction.run(() => super.loadToken());
  }

  late final _$setTokenAsyncAction =
      AsyncAction('CommonStoreBase.setToken', context: context);

  @override
  Future<dynamic> setToken(String token) {
    return _$setTokenAsyncAction.run(() => super.setToken(token));
  }

  late final _$removeTokenAsyncAction =
      AsyncAction('CommonStoreBase.removeToken', context: context);

  @override
  Future<dynamic> removeToken() {
    return _$removeTokenAsyncAction.run(() => super.removeToken());
  }

  @override
  String toString() {
    return '''
jwt: ${jwt},
hasToken: ${hasToken}
    ''';
  }
}
