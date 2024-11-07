import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Track Your Nutrition',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        debugPrint('Camera button pressed');
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Food Photo'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        debugPrint('Food diary button pressed');
                      },
                      icon: const Icon(Icons.book),
                      label: const Text('Food Diary'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        debugPrint('Recipes button pressed');
                      },
                      icon: const Icon(Icons.restaurant_menu),
                      label: const Text('Recipes'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}