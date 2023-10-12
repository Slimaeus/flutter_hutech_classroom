import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/screens/login_screen.dart';

class RouteManager {
  RouteManager._();

  static String login = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    login: (context) => const LoginScreen()
  };
}
