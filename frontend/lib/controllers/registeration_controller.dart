import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../utils/api_endpoints.dart';

class RegistrationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(String role) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    print('Accepted: Name: $name, Email: $email, Password: $password');

    // Create a Dio instance
    final Dio dio = Dio();

    try {
      final response = await dio.post(
        '${ApiEndPoints.baseUrl}${ApiEndPoints.registerEmail}',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 201) {
        // User registered successfully
        print('User registered: ${response.data}');
      } else {
        // Handle error
        print('Failed to register user: ${response.data}');
      }
    } catch (e) {
      // Handle Dio error
      print('Error occurred: $e');
    }
  }

  @override
  void onClose() {
    // Dispose of controllers only when the controller is closed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
