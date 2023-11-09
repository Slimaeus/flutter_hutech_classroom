import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

mixin BaseStoreMixin on Store {
  @protected

  ///onInit called when initState called
  void onInit(BuildContext context);

  @protected

  ///didChangeDependencies called when dependencies changed
  void didChangeDependencies() {}

  @protected

  ///onWidgetBuildDone called when build done widget
  Future<void> onWidgetBuildDone(BuildContext context);

  @protected

  ///onDispose called when dispose
  void onDispose(BuildContext context);

  @protected
  void resetValue();
}
