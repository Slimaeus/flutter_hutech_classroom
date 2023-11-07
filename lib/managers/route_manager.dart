import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/screens/comparison_screen.dart';
import 'package:flutter_hutech_classroom/screens/home_screen.dart';
import 'package:flutter_hutech_classroom/screens/image_input_screen.dart';
import 'package:flutter_hutech_classroom/screens/login_screen.dart';
import 'package:flutter_hutech_classroom/screens/profile_screen.dart';
import 'package:flutter_hutech_classroom/screens/result_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_screen.dart';
import 'package:flutter_hutech_classroom/screens/student_transcript_details_screen.dart';
import 'package:flutter_hutech_classroom/screens/student_transcript_screen.dart';

class RouteManager {
  RouteManager._();

  static String home = 'home';
  static String login = 'login';
  static String studentTranscript = 'studentTranscript';
  static String studentTranscriptDetails = 'studentTranscriptDetails';
  static String imageInput = 'imageInput';
  static String scan = 'scan';
  static String comparison = 'comparison';
  static String result = 'result';
  static String profile = 'profile';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(title: 'TRANG CHỦ'),
    login: (context) => const LoginScreen(title: 'HUTECH SCAN SYSTEM'),
    studentTranscript: (context) =>
        const StudentTranscriptScreen(title: 'TRA CỨU BẢNG ĐIỂM'),
    studentTranscriptDetails: (context) =>
        const StudentTranscriptDetailsScreen(title: 'BẢNG ĐIỂM'),
    imageInput: (context) => const ImageInputScreen(title: 'NHẬP ẢNH BẢNG ĐIỂM'),
    scan: (context) => const ScanScreen(title: 'SCAN BẢNG ĐIỂM'),
    comparison: (context) => const ComparisonScreen(title: 'SO SÁNH KIỂM TRA'),
    result: (context) => const ResultScreen(title: 'KẾT QUẢ KIỂM TRA'),
    profile: (context) => const ProfileScreen(title: 'HỒ SƠ CÁ NHÂN'),
  };
}
