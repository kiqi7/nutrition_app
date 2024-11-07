// lib/core/services/web_storage_service.dart
import 'package:hive/hive.dart';

class WebStorageService {
  static final WebStorageService _instance = WebStorageService._internal();
  factory WebStorageService() => _instance;
  WebStorageService._internal();

  Future<void> initializeStorage() async {
    // Initialize Hive for web
    Hive.init('nutrition_app');
  }
}