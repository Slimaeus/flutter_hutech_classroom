import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/main.dart';
import 'package:flutter_hutech_classroom/screens/login_screen.dart';

class RouteManager {
  RouteManager._();

  static String home = 'home';
  static String login = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const MyHomePage(title: 'Trang chủ'),
    login: (context) => const LoginScreen()
  };
}
