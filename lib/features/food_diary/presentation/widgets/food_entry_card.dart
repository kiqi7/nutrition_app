// lib/features/food_diary/presentation/widgets/food_entry_card.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/models/food_entry.dart';

class FoodEntryCard extends StatelessWidget {
  final FoodEntry entry;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const FoodEntryCard({
    super.key,
    required this.entry,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.imagePath != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(
                File(entry.imagePath!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Calories: ${entry.calories.toStringAsFixed(0)} kcal',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _NutrientChip(
                      label: 'Protein',
                      value: entry.protein,
                      color: Colors.red,
                    ),
                    _NutrientChip(
                      label: 'Carbs',
                      value: entry.carbs,
                      color: Colors.blue,
                    ),
                    _NutrientChip(
                      label: 'Fat',
                      value: entry.fat,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _NutrientChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          '$label: ${value.toStringAsFixed(1)}g',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }
}