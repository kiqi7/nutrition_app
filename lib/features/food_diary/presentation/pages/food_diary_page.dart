// lib/features/food_diary/presentation/pages/food_diary_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/food_entry.dart';

class FoodDiaryPage extends StatefulWidget {
  const FoodDiaryPage({super.key});

  @override
  State<FoodDiaryPage> createState() => _FoodDiaryPageState();
}

class _FoodDiaryPageState extends State<FoodDiaryPage> {
  DateTime selectedDate = DateTime.now();
  final List<FoodEntry> mockEntries = [
    FoodEntry(
      id: '1',
      name: 'Apple',
      calories: 95,
      protein: 0.5,
      carbs: 25,
      fat: 0.3,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    FoodEntry(
      id: '2',
      name: 'Chicken Salad',
      calories: 350,
      protein: 25,
      carbs: 10,
      fat: 12,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
  ];

  double get totalCalories => mockEntries.fold(0, (sum, entry) => sum + entry.calories);
  double get totalProtein => mockEntries.fold(0, (sum, entry) => sum + entry.protein);
  double get totalCarbs => mockEntries.fold(0, (sum, entry) => sum + entry.carbs);
  double get totalFat => mockEntries.fold(0, (sum, entry) => sum + entry.fat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildNutritionSummary(),
          const Divider(),
          Expanded(
            child: _buildFoodList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to food capture page
          Navigator.pop(context);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildNutritionSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            DateFormat('EEEE, MMMM d').format(selectedDate),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutrientCircle('Calories', totalCalories, 2000, Colors.orange),
              _buildNutrientCircle('Protein', totalProtein, 50, Colors.red),
              _buildNutrientCircle('Carbs', totalCarbs, 250, Colors.blue),
              _buildNutrientCircle('Fat', totalFat, 70, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientCircle(String label, double value, double goal, Color color) {
    final percentage = (value / goal).clamp(0.0, 1.0);
    
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                color: color,
                strokeWidth: 8,
              ),
              Center(
                child: Text(
                  value.toStringAsFixed(0),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildFoodList() {
    return ListView.builder(
      itemCount: mockEntries.length,
      itemBuilder: (context, index) {
        final entry = mockEntries[index];
        return Dismissible(
          key: Key(entry.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              mockEntries.removeAt(index);
            });
          },
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.food_bank),
            ),
            title: Text(entry.name),
            subtitle: Text(
              'Calories: ${entry.calories.toStringAsFixed(0)} • '
              'P: ${entry.protein.toStringAsFixed(1)}g • '
              'C: ${entry.carbs.toStringAsFixed(1)}g • '
              'F: ${entry.fat.toStringAsFixed(1)}g',
            ),
            trailing: Text(
              DateFormat('HH:mm').format(entry.timestamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}