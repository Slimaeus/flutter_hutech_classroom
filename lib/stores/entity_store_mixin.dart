import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

mixin EntityStoreMixin<TEntity> on Store {
  @protected
  void setSelected(TEntity value);
}
