import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/auth/login_form.dart';
import 'package:flutter_hutech_classroom/widgets/layout/custom_login_indicator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserStore userStore;
  late CommonStore commonStore;

  @override
  void initState() {
    super.initState();
    userStore = context.read<UserStore>();
    userStore.onInit(context);
    commonStore = context.read<CommonStore>();
    commonStore.loadToken().then((_) {
      if (commonStore.hasToken) {
        userStore.getCurrentUser().then((result) {
          if (result) {
            Navigator.popAndPushNamed(context, RouteManager.home);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            PathManager.logoHutech,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
        return userStore.isLoggingIn
            ? customLoginIndicator(context)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Platform.isWindows
                              ? MediaQuery.of(context).size.width * 0.2
                              : 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              PathManager.logoHutechScanSystem,
                              height: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'HỆ THỐNG SCAN${Platform.isWindows ? " " : "\n"}KIỂM TRA BẢNG ĐIỂM SINH VIÊN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Platform.isWindows ? 22 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.06),
                              child: LoginForm(
                                onLogin: (userName, password) async {
                                  var isSucceed =
                                      await userStore.login(userName, password);
                                  if (isSucceed && context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Đăng nhập thành công!"),
                                      backgroundColor: Colors.blue,
                                      duration: Duration(seconds: 2),
                                    ));
                                    Navigator.pushReplacementNamed(
                                        context, RouteManager.home);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
