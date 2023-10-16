import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/screens/home_screen.dart';
import 'package:flutter_hutech_classroom/screens/login_screen.dart';

class RouteManager {
  RouteManager._();

  static String home = 'home';
  static String login = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(title: 'TRANG CHỦ'),
    login: (context) => const LoginScreen(title: 'HUTECH CLASSROOM')
  };
}
