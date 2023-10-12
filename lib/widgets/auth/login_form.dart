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
  final FocusNode _focusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  void _login() {
    _form.currentState!.validate();
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
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            onChanged: (value) {},
            validator: (value) {
              if (value == "Hi") return "Not good!";
              return null;
            },
            decoration: const InputDecoration(labelText: 'Tên tài khoản'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Mật khẩu'),
            obscureText: true,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(_focusNode),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            focusNode: _focusNode,
            child: const Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }
}
