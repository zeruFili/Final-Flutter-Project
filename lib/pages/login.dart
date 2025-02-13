import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../utils/api_endpoints.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                bool success = await loginUser(
                  emailController.text,
                  passwordController.text,
                );

                if (success) {
                  // Only navigate to the home page if login was successful
                  Get.offAllNamed(
                      ApiEndPoints.home); // Use offAll to clear previous routes
                } else {
                  // Optionally, show an error message to the user
                  Get.snackbar(
                      'Login Failed', 'Please check your credentials.');
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(ApiEndPoints.registerEmail);
              },
              child: Text('Go to Register'),
            ),
          ],
        ),
      ),
    );
  }
}
