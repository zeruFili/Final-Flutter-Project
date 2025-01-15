import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/api_endpoints.dart';
import 'screens/register.dart';
import 'screens/login.dart';
import 'screens/home.dart';
// Replace with the actual path to your checkAuth file
import 'controllers/checkauth_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation',
      initialRoute: ApiEndPoints.registerEmail, // Default initial route
      getPages: [
        GetPage(name: ApiEndPoints.registerEmail, page: () => RegisterScreen()),
        GetPage(name: ApiEndPoints.loginEmail, page: () => LoginScreen()),
        GetPage(
            name: ApiEndPoints.home,
            page: () => HomeScreen()), // Add HomeScreen route
      ],
    );
  }

  MyApp() {
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final isAuthenticated =
        await checkAuth(); // Assume checkAuth returns a boolean

    if (isAuthenticated) {
      // Navigate to HomeScreen if authenticated
      Get.offAllNamed(ApiEndPoints.home);
    } else {
      // Navigate to RegisterScreen if not authenticated
      Get.offAllNamed(ApiEndPoints.registerEmail);
    }
  }
}
