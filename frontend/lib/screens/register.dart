import 'package:flutter/material.dart';
import '../controllers/registeration_controller.dart';
import '../utils/api_endpoints.dart';
import 'auth/widgets/email_validator.dart'; // Import the email validator
import 'package:get/get.dart';
import 'auth/widgets/password_strength.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  String password = '';
  String emailError = '';
  String nameError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: registrationController.nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: nameError.isNotEmpty
                    ? nameError
                    : null, // Show error message
              ),
            ),
            TextField(
              controller: registrationController.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailError.isNotEmpty
                    ? emailError
                    : null, // Show error message
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value; // Update the state with the new password
                });
              },
              controller: registrationController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            // Display Password Strength Meter
            PasswordStrengthMeter(password: password),

            ElevatedButton(
              onPressed: () {
                final email = registrationController.emailController.text;
                final name = registrationController.nameController.text;

                // Validate the email and name
                bool isEmailValid = isValidEmail(email);
                bool isNameValid = name.isNotEmpty;

                setState(() {
                  emailError =
                      isEmailValid ? '' : 'Please enter a valid email address.';
                  nameError = isNameValid ? '' : 'Please enter your name.';
                });

                // Stop further execution if validation fails
                if (!isEmailValid || !isNameValid) {
                  return;
                }

                // Proceed with registration if both email and name are valid
                registrationController.registerUser('user'); // Pass role
                registrationController.nameController.clear();
                registrationController.emailController.clear();
                registrationController.passwordController.clear();

                Get.toNamed(ApiEndPoints.loginEmail);
              },
              child: Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                // Print accepted parameters
                print(
                    'Accepted: Name: ${registrationController.nameController.text}, '
                    'Email: ${registrationController.emailController.text}, '
                    'Password: ${registrationController.passwordController.text}');
                Get.toNamed(ApiEndPoints.loginEmail);
              },
              child: Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
