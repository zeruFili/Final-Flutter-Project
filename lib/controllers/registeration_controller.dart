import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../apis/registration_api.dart'; // Import the RegistrationApis class

class RegistrationController extends GetxController {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController(); // Optional

  Future<void> registerUser() async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String birthday = birthdayController.text; // Assuming birthday is a string
    String gender = genderController.text; // Assuming gender is a string

    print(
        'Accepted: Firstname: $firstname, Lastname: $lastname, Email: $email, Password: $password');

    final registrationApi =
        RegistrationApis(); // Create an instance of RegistrationApis

    // Prepare the data to be sent
    var data = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'birthday': birthday,
      'gender': gender,
    };

    try {
      final response =
          await registrationApi.register(data); // Call the register method

      if (response.statusCode == 201) {
        // User registered successfully
        print('User registered: ${response.data}');
      } else {
        // Handle error
        print('Failed to register user: ${response.data}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error occurred: $e');
    }
  }

  @override
  void onClose() {
    // Dispose of controllers only when the controller is closed
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthdayController.dispose();
    genderController.dispose(); // Optional
    super.onClose();
  }
}
