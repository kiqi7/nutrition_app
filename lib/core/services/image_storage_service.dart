// lib/core/services/image_storage_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class ImageStorageService {
  static final ImageStorageService _instance = ImageStorageService._internal();
  factory ImageStorageService() => _instance;
  ImageStorageService._internal();

  Future<String> saveImage(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory('${directory.path}/food_images');
      
      // Create directory if it doesn't exist
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      // Generate unique filename
      final uuid = const Uuid().v4();
      final extension = path.extension(imageFile.path);
      final fileName = '$uuid$extension';
      
      // Copy image to app directory
      final savedImage = await imageFile.copy('${imageDir.path}/$fileName');
      return savedImage.path;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}