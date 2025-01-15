import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/api_endpoints.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Login Screen
            Get.toNamed(ApiEndPoints.loginEmail);
          },
          child: Text('Go to Login'),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Register Screen
            Get.toNamed(ApiEndPoints.registerEmail);
          },
          child: Text('Go to Register'),
        ),
      ),
    );
  }
}
