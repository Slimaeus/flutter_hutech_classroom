import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/stores/base_store_mixin.dart';
import 'package:mobx/mobx.dart';

abstract class BaseStore with Store, BaseStoreMixin {
  @override
  void onInit(BuildContext context) {}

  @override
  void onDispose(BuildContext context) {}

  @override
  Future<void> onWidgetBuildDone(BuildContext context) async {}

  @override
  void resetValue() {}
}
