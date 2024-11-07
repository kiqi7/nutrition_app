// lib/core/services/storage_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  Future<String> saveImage(dynamic imageSource) async {
    if (kIsWeb) {
      return _saveImageWeb(imageSource);
    } else {
      throw UnimplementedError('Mobile implementation not available');
    }
  }

  Future<String> _saveImageWeb(dynamic imageFile) async {
    final completer = Completer<String>();
    final uuid = const Uuid().v4();
    final key = 'image_$uuid';

    if (imageFile is List<int>) {
      // Handle byte data
      final base64String = base64Encode(imageFile);
      _saveToLocalStorage(key, base64String);
      completer.complete(key);
    } else {
      // Handle File object from image picker
      final reader = html.FileReader();
      reader.readAsDataUrl(imageFile as html.File);
      reader.onLoad.listen((_) {
        final result = reader.result as String;
        _saveToLocalStorage(key, result);
        completer.complete(key);
      });
    }

    return completer.future;
  }

  void _saveToLocalStorage(String key, String value) {
    html.window.localStorage[key] = value;
  }

  String? getImageUrl(String key) {
    if (kIsWeb) {
      return html.window.localStorage[key];
    }
    return null;
  }

  Future<void> deleteImage(String key) async {
    if (kIsWeb) {
      html.window.localStorage.remove(key);
    }
  }
}