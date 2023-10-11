import 'package:flutter/material.dart';
import 'package:flutter_hutech_classroom/widgets/auth/login_form.dart';
import 'dart:developer' as developer;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: LoginForm(
            onLogin: (username, password) {
              // Handle login logic here, e.g., validate credentials
              // If login successful, navigate to the next screen
              developer.log('Username: $username, Password: $password');
            },
          ),
        ),
      ),
    );
  }
}
