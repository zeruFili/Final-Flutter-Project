import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/api_endpoints.dart'; // Import the ApiEndPoints class

class ImageUploadController extends GetxController {
  var selectedImageBytes =
      Rx<Uint8List?>(null); // Observable for selected image bytes
  var selectedImageName = ''.obs; // Observable for selected image name

  /// Pick an image (you would typically call this in your UI)
  Future<void> pickImage(Uint8List imageBytes, String imageName) async {
    selectedImageBytes.value = imageBytes; // Set selected image bytes
    selectedImageName.value = imageName; // Set selected image name
  }

  /// Upload image to the server
  Future<void> uploadImage() async {
    if (selectedImageBytes.value == null || selectedImageName.value.isEmpty)
      return;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ApiEndPoints.baseUrl}${ApiEndPoints.create}'), // Use the API endpoint
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // The key expected by the server
          selectedImageBytes.value!,
          filename: selectedImageName.value, // Filename of the uploaded file
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // You might want to call fetchImages from the ImageController here if needed
      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
