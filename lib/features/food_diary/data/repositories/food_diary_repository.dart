// lib/features/food_diary/data/repositories/food_diary_repository.dart
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/food_entry.dart';
import '../../../../core/services/image_storage_service.dart';

class FoodDiaryRepository {
  static const String _boxName = 'food_entries';
  final _imageStorage = ImageStorageService();
  
  Future<Box<FoodEntry>> get _box async => 
      await Hive.openBox<FoodEntry>(_boxName);

  Future<List<FoodEntry>> getEntriesForDate(DateTime date) async {
    final box = await _box;
    
    return box.values.where((entry) {
      final entryDate = DateTime(
        entry.timestamp.year,
        entry.timestamp.month,
        entry.timestamp.day,
      );
      final targetDate = DateTime(
        date.year,
        date.month,
        date.day,
      );
      return entryDate == targetDate;
    }).toList();
  }

  Future<void> addEntry(FoodEntry entry, File? imageFile) async {
    final box = await _box;
    String? imagePath;
    
    if (imageFile != null) {
      imagePath = await _imageStorage.saveImage(imageFile);
    }
    
    final newEntry = entry.copyWith(
      id: const Uuid().v4(),
      imagePath: imagePath,
    );
    
    await box.put(newEntry.id, newEntry);
  }

  Future<void> deleteEntry(FoodEntry entry) async {
    final box = await _box;
    
    // Delete image if exists
    if (entry.imagePath != null) {
      await _imageStorage.deleteImage(entry.imagePath!);
    }
    
    await box.delete(entry.id);
  }

  Future<void> updateEntry(FoodEntry entry, File? newImageFile) async {
    final box = await _box;
    String? imagePath = entry.imagePath;
    
    // Handle image update
    if (newImageFile != null) {
      // Delete old image if exists
      if (entry.imagePath != null) {
        await _imageStorage.deleteImage(entry.imagePath!);
      }
      // Save new image
      imagePath = await _imageStorage.saveImage(newImageFile);
    }
    
    final updatedEntry = entry.copyWith(imagePath: imagePath);
    await box.put(entry.id, updatedEntry);
  }
}