import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/managers/path_manager.dart';
import 'package:flutter_hutech_classroom/managers/route_manager.dart';
import 'package:flutter_hutech_classroom/stores/common_store.dart';
import 'package:flutter_hutech_classroom/stores/user_store.dart';
import 'package:flutter_hutech_classroom/widgets/auth/login_form.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:developer' as developer;

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
    commonStore.loadToken().then((value) {
      if (commonStore.jwt != null) {
        Navigator.popAndPushNamed(context, RouteManager.home);
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
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(PathManager.logoHutechScanSystem,
                      height: MediaQuery.of(context).size.height * 0.1),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: const LinearProgressIndicator()),
                ],
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              PathManager.logoHutechScanSystem,
                              height: 150,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'HỆ THỐNG SCAN KIỂM TRA BẢNG ĐIỂM SINH VIÊN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
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
