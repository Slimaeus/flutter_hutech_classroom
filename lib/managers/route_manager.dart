import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/screens/home_screen.dart';
import 'package:flutter_hutech_classroom/screens/login_screen.dart';
import 'package:flutter_hutech_classroom/screens/profile_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_screen.dart';
import 'package:flutter_hutech_classroom/screens/student_transcript_screen.dart';

class RouteManager {
  RouteManager._();

  static String home = 'home';
  static String login = 'login';
  static String studentTranscript = 'studentTranscript';
  static String scan = 'scan';
  static String profile = 'profile';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(title: 'TRANG CHỦ'),
    login: (context) => const LoginScreen(title: 'HUTECH SCAN SYSTEM'),
    studentTranscript: (context) =>
        const StudentTranscriptScreen(title: 'BẢNG ĐIỂM'),
    scan: (context) => const ScanScreen(title: 'SCAN KIỂM TRA'),
    profile: (context) => const ProfileScreen(title: 'HỒ SƠ CÁ NHÂN'),
  };
}
