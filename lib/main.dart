import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/checkauth_controller.dart';
import 'utils/api_endpoints.dart';
import 'pages/login.dart';
import 'pages/home_page.dart';
import 'pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService authController = AuthService();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation',
      // initialRoute: '/',
      getPages: [
        GetPage(name: ApiEndPoints.registerEmail, page: () => RegisterScreen()),
        GetPage(name: ApiEndPoints.loginEmail, page: () => LoginScreen()),
        GetPage(
            name: ApiEndPoints.home,
            page: () => HomePage()), // Add HomePage route
      ],
      home: FutureBuilder<bool>(
        future: authController.checkAuth(), // Call the checkAuth method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!) {
            return HomePage(); // Navigate to home if authenticated
          } else {
            return LoginScreen(); // Navigate to login if not authenticated
          }
        },
      ),
    );
  }
}





//  Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'GetX Navigation',
//       initialRoute: ApiEndPoints.loginEmail, // Default initial route
//       getPages: [
//         GetPage(name: ApiEndPoints.registerEmail, page: () => RegisterScreen()),
//         GetPage(name: ApiEndPoints.loginEmail, page: () => LoginScreen()),
//         GetPage(
//             name: ApiEndPoints.home,
//             page: () => HomePage()), // Add HomePage route
//       ],
//     );
//   }