// lib/features/food_diary/presentation/widgets/food_image.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/storage_service.dart';

class FoodImage extends StatelessWidget {
  final String? imageKey;
  final double height;
  final double width;
  final BoxFit fit;

  const FoodImage({
    super.key,
    required this.imageKey,
    this.height = 200,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageKey == null) {
      return const SizedBox.shrink();
    }

    if (kIsWeb) {
      final imageUrl = StorageService().getImageUrl(imageKey!);
      if (imageUrl != null) {
        return Image.network(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
        );
      }
    } else {
      return Image.file(
        File(imageKey!),
        height: height,
        width: width,
        fit: fit,
      );
    }

    return const SizedBox.shrink();
  }
}