// lib/features/food_capture/presentation/pages/food_analysis_page.dart
import 'package:flutter/material.dart';
import 'dart:io';

class FoodAnalysisPage extends StatefulWidget {
  final File imageFile;

  const FoodAnalysisPage({super.key, required this.imageFile});

  @override
  State<FoodAnalysisPage> createState() => _FoodAnalysisPageState();
}

class _FoodAnalysisPageState extends State<FoodAnalysisPage> {
  bool _isAnalyzing = true;
  Map<String, dynamic>? _nutritionData;

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock nutrition data
    setState(() {
      _isAnalyzing = false;
      _nutritionData = {
        'name': 'Apple',
        'calories': 95,
        'protein': 0.5,
        'carbs': 25.0,
        'fat': 0.3,
        'fiber': 4.0,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Analysis'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              widget.imageFile,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            if (_isAnalyzing)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Analyzing food image...'),
                  ],
                ),
              )
            else if (_nutritionData != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nutritionData!['name'],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    _NutritionCard(nutritionData: _nutritionData!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NutritionCard extends StatelessWidget {
  final Map<String, dynamic> nutritionData;

  const _NutritionCard({required this.nutritionData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition Facts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _NutritionRow('Calories', '${nutritionData['calories']} kcal'),
            _NutritionRow('Protein', '${nutritionData['protein']}g'),
            _NutritionRow('Carbohydrates', '${nutritionData['carbs']}g'),
            _NutritionRow('Fat', '${nutritionData['fat']}g'),
            _NutritionRow('Fiber', '${nutritionData['fiber']}g'),
          ],
        ),
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}