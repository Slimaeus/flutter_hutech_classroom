import 'dart:io';

import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginForm({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController =
      TextEditingController(text: '2080600803');
  final TextEditingController _passwordController =
      TextEditingController(text: 'P@ssw0rd');
  final _form = GlobalKey<FormState>();

  void _login() {
    if (_form.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      widget.onLogin(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    fontSize: Platform.isWindows ? 40 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == "Hi") return "Not good!";
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tên tài khoản',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == "Hi") return "Not good!";
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: _login,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Version 1.0.0\n'
                  '© 2023 Khoa Công nghệ thông tin - Trường ĐH Công nghệ TP.HCM HUTECH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Platform.isWindows ? 20 : 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
