import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/api_endpoints.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'screens/image_upolad.dart'; // Note: Fixed typo here
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
      ],
    );
  }
}

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  Uint8List? _selectedImageBytes; // To store the image bytes
  String? _selectedImageName; // To store the image name
  List<dynamic> _allImages = []; // To store all fetched images

  @override
  void initState() {
    super.initState();
    fetchImages(); // Fetch images upon initialization
  }

  Future<void> fetchImages() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/get-image'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _allImages = data['data'];
        });
        print('_all images: $_allImages');
      } else {
        print('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes =
          await pickedFile.readAsBytes(); // Read the image as bytes
      setState(() {
        _selectedImageBytes = imageBytes;
        _selectedImageName = pickedFile.name;
      });
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImageBytes == null || _selectedImageName == null) return;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/upload-image'),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // The key expected by the server
          _selectedImageBytes!,
          filename: _selectedImageName, // Filename of the uploaded file
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        fetchImages(); // Refresh the images after upload
      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Uploader (Web)'),
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
            if (_selectedImageBytes != null)
              Column(
                children: [
                  Image.memory(
                    _selectedImageBytes!,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: uploadImage,
                    child: Text('Upload Image'),
                  ),
                ],
              ),
            Expanded(
              child: _allImages.isEmpty
                  ? Center(child: Text('No images available'))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _allImages.length,
                      itemBuilder: (context, index) {
                        print(_allImages[index]['image']);
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'images/${_allImages[index]['image']}'), // Adjust based on your API response
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
