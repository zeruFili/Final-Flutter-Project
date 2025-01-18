import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/image_controllers.dart'; // Import the ImageController

class ImageView extends StatelessWidget {
  final ImageController imageController =
      Get.put(ImageController()); // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    // Fetch images when the widget is built
    imageController.fetchImages();

    return Scaffold(
      appBar: AppBar(
        title: Text('Image View'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Use Obx to listen for changes in the observable list
              if (imageController.allImages.isEmpty) {
                return Center(child: Text('No images available'));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: imageController.allImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/${imageController.allImages[index]['image']}', // Use imageController to access allImages
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Image Uploader
              Get.toNamed('/upload-image');
            },
            child: Text('Go to Image Uploader'),
          ),
        ],
      ),
    );
  }
}
