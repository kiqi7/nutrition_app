import 'package:hive/hive.dart';

part 'food_entry.g.dart';

@HiveType(typeId: 0)
class FoodEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double calories;

  @HiveField(3)
  final double protein;

  @HiveField(4)
  final double carbs;

  @HiveField(5)
  final double fat;

  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final String? imageKey;

  FoodEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.timestamp,
    this.imageKey,
  });
}