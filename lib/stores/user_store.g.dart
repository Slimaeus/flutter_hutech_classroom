// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$userAtom = Atom(name: 'UserStoreBase.user', context: context);

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('UserStoreBase.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void resetValue() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.resetValue');
    try {
      return super.resetValue();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
