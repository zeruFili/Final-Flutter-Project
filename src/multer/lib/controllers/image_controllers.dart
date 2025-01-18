import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/api_endpoints.dart';

class ImageController extends GetxController {
  var allImages =
      <dynamic>[].obs; // Observable list to store all fetched images

  /// Fetch images from the server
  Future<void> fetchImages() async {
    try {
      final request = http.Request(
        'GET',
        Uri.parse(
            '${ApiEndPoints.baseUrl}${ApiEndPoints.getimage}'), // Replace with the appropriate endpoint
      );

      final response = await request.send(); // Send the request

      if (response.statusCode == 200) {
        // Read the response body
        final responseBody = await http.Response.fromStream(response);
        final data = json.decode(responseBody.body);
        allImages.value = data['data']; // Update the observable list
        print('_all images: ${allImages.value}');
      } else {
        print('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }
}
