import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/auth/login_form.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserStore userStore;

  @override
  void initState() {
    super.initState();
    userStore = context.read<UserStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logoHutech.png',
          ),
        ),
        title: const Text(
          "HUTECH CLASSROOM",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logo-hutech-classroom.png',
                              height: 200,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'HỆ THỐNG SCAN KIỂM TRA BẢNG ĐIỂM SINH VIÊN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginForm(
                                onLogin: (userName, password) async {
                                  developer.log(
                                      'Username: $userName, Password: $password');
                                  var isSucceed =
                                      await userStore.login(userName, password);
                                  if (isSucceed && context.mounted) {
                                    Navigator.pushReplacementNamed(
                                        context, RouteManager.home);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
