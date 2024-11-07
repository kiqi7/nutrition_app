// lib/features/food_capture/presentation/pages/camera_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'food_analysis_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
        });
        _processImage();
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
        _processImage();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _processImage() {
    if (_imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodAnalysisPage(imageFile: _imageFile!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Food'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) ...[
              Image.file(
                _imageFile!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take Picture'),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick from Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}