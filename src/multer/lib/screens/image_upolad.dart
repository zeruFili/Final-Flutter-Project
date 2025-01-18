import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker
import '../controllers/image_upload_controller.dart'; // Import the ImageUploadController

class ImageUploader extends StatelessWidget {
  final ImageUploadController uploadController =
      Get.put(ImageUploadController()); // Instantiate the controller

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes =
          await pickedFile.readAsBytes(); // Read the image as bytes
      uploadController.pickImage(imageBytes,
          pickedFile.name); // Use the controller to set the selected image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Uploader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (uploadController.selectedImageBytes.value != null) {
                return Column(
                  children: [
                    Image.memory(
                      uploadController.selectedImageBytes.value!,
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await uploadController.uploadImage();
                        // Optionally refresh images after upload
                        // imageController.fetchImages(); // Uncomment if you have an ImageController instance
                      },
                      child: Text('Upload Image'),
                    ),
                  ],
                );
              } else {
                return Container(); // No image selected
              }
            }),
          ],
        ),
      ),
    );
  }
}
