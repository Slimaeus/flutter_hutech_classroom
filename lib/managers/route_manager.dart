import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/classroom_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/exercise_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/group_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/member_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/post_comment_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/post_screen.dart';
import 'package:flutter_hutech_classroom/screens/classroom_system/transcript_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/comparison_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/home_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/image_input_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/login_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/multiple_image_input_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/multitple_comparision_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/profile_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/result_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/scan_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/student_transcript_details_screen.dart';
import 'package:flutter_hutech_classroom/screens/scan_system/student_transcript_screen.dart';

class RouteManager {
  RouteManager._();

  static String home = 'home';
  static String login = 'login';
  static String studentTranscript = 'studentTranscript';
  static String studentTranscriptDetails = 'studentTranscriptDetails';
  static String imageInput = 'imageInput';
  static String multipleImageInput = 'multipleImageInput';
  static String scan = 'scan';
  static String comparison = 'comparison';
  static String mulipleComparision = 'multipleComparision';
  static String result = 'result';
  static String profile = 'profile';
  static String classroom = 'classroom';
  static String post = 'post';
  static String postcomment = 'postcomment';
  static String exercise = 'exercise';
  static String group = 'group';
  static String transcript = 'transcript';
  static String member = 'member';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(title: 'TRANG CHỦ'),
    login: (context) => const LoginScreen(title: 'HUTECH SCAN SYSTEM'),
    studentTranscript: (context) =>
        const StudentTranscriptScreen(title: 'TRA CỨU BẢNG ĐIỂM'),
    studentTranscriptDetails: (context) =>
        const StudentTranscriptDetailsScreen(title: 'BẢNG ĐIỂM'),
    imageInput: (context) =>
        const ImageInputScreen(title: 'NHẬP ẢNH BẢNG ĐIỂM'),
    multipleImageInput: (context) =>
        const MultipleImageInputScreen(title: 'NHẬP ẢNH BẢNG ĐIỂM'),
    scan: (context) => const ScanScreen(title: 'SCAN BẢNG ĐIỂM'),
    comparison: (context) => const ComparisonScreen(title: 'SO SÁNH KIỂM TRA'),
    mulipleComparision: (context) => const MultipleComparisonScreen(
        title: 'SO SÁNH KIỂM TRA'),
    result: (context) => const ResultScreen(title: 'KẾT QUẢ KIỂM TRA'),
    profile: (context) => const ProfileScreen(title: 'HỒ SƠ CÁ NHÂN'),
    classroom: (context) => const ClassroomScreen(title: 'LỚP HỌC'),
    post: (context) => const PostScreen(title: 'THÔNG BÁO'),
    postcomment: (context) => const PostCommentScreen(title: 'CHI TIẾT BÀI ĐĂNG'),
    exercise: (context) => const ExerciseScreen(title: 'BÀI TẬP'),
    group: (context) => const GroupScreen(title: 'NHÓM SINH VIÊN'),
    transcript: (context) => const TranscriptScreen(title: 'BẢNG ĐIỂM'),
    member: (context) => const MemberScreen(title: 'THÀNH VIÊN'),
  };
}
