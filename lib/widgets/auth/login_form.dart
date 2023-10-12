import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginForm({super.key, required this.onLogin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    widget.onLogin(username, password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(labelText: 'Tên tài khoản'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Mật khẩu'),
          obscureText: true,
          onSubmitted: (value) => _focusNode.requestFocus(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          focusNode: _focusNode,
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }
}
