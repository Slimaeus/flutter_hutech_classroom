import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderManager {
  ProviderManager._();

  static List<SingleChildWidget> providers = [
    Provider(
      create: (_) => UserStore(),
    )
  ];
}
