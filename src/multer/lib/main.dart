import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/api_endpoints.dart';
import 'screens/image_upolad.dart'; // Import the image uploader
import 'screens/image_view.dart'; // Import the image view

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation',
      initialRoute: '/get-image', // Start with the image view
      getPages: [
        GetPage(
            name: '/get-image', page: () => ImageView()), // Image View route
        GetPage(
            name: '/upload-image',
            page: () => ImageUploader()), // Image Uploader route
        // HomeScreen route
      ],
    );
  }
}
