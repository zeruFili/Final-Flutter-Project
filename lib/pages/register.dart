import 'package:flutter/material.dart';
import '../controllers/registeration_controller.dart'; // Corrected import
import '../utils/api_endpoints.dart';
import '../widgets/email_validator.dart'; // Import the email validator
import 'package:get/get.dart';
// import 'auth/widgets/password_strength.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  String password = '';
  String emailError = '';
  String firstnameError = '';
  String lastnameError = '';
  String birthdayError = '';
  String genderError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: registrationController.firstnameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                errorText: firstnameError.isNotEmpty ? firstnameError : null,
              ),
            ),
            TextField(
              controller: registrationController.lastnameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                errorText: lastnameError.isNotEmpty ? lastnameError : null,
              ),
            ),
            TextField(
              controller: registrationController.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailError.isNotEmpty ? emailError : null,
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
            // Password Strength Meter
            // PasswordStrengthMeter(password: password),

            TextField(
              controller: registrationController.birthdayController,
              decoration: InputDecoration(
                labelText: 'Birthday (YYYY-MM-DD)',
                errorText: birthdayError.isNotEmpty ? birthdayError : null,
              ),
            ),
            TextField(
              controller: registrationController.genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                errorText: genderError.isNotEmpty ? genderError : null,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final email = registrationController.emailController.text;
                final firstname =
                    registrationController.firstnameController.text;
                final lastname = registrationController.lastnameController.text;
                final birthday = registrationController.birthdayController.text;
                final gender = registrationController.genderController.text;

                // Validate the email, names, birthday, and gender
                bool isEmailValid = isValidEmail(email);
                bool isFirstnameValid = firstname.isNotEmpty;
                bool isLastnameValid = lastname.isNotEmpty;
                bool isBirthdayValid =
                    birthday.isNotEmpty; // Add your birthday validation
                bool isGenderValid =
                    gender.isNotEmpty; // Add your gender validation

                setState(() {
                  emailError =
                      isEmailValid ? '' : 'Please enter a valid email address.';
                  firstnameError =
                      isFirstnameValid ? '' : 'Please enter your first name.';
                  lastnameError =
                      isLastnameValid ? '' : 'Please enter your last name.';
                  birthdayError =
                      isBirthdayValid ? '' : 'Please enter your birthday.';
                  genderError =
                      isGenderValid ? '' : 'Please enter your gender.';
                });

                // Stop further execution if validation fails
                if (!isEmailValid ||
                    !isFirstnameValid ||
                    !isLastnameValid ||
                    !isBirthdayValid ||
                    !isGenderValid) {
                  return;
                }

                // Proceed with registration if all validations are valid
                registrationController.registerUser();
                registrationController.firstnameController.clear();
                registrationController.lastnameController.clear();
                registrationController.emailController.clear();
                registrationController.passwordController.clear();
                registrationController.birthdayController.clear();
                registrationController.genderController.clear();

                Get.toNamed(ApiEndPoints.loginEmail);
              },
              child: Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                // Print accepted parameters
                print(
                    'Accepted: First Name: ${registrationController.firstnameController.text}, '
                    'Last Name: ${registrationController.lastnameController.text}, '
                    'Email: ${registrationController.emailController.text}, '
                    'Password: ${registrationController.passwordController.text}, '
                    'Birthday: ${registrationController.birthdayController.text}, '
                    'Gender: ${registrationController.genderController.text}');
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
