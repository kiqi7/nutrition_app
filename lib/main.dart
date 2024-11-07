import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            minimumSize: const Size(200, 48),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition App'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 24),
                Text(
                  'Track Your Nutrition',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 40),
                _buildFeatureButton(
                  context,
                  'Analyze Food',
                  Icons.camera_alt,
                  onPressed: () {
                    debugPrint('Camera button pressed');
                  },
                ),
                const SizedBox(height: 16),
                _buildFeatureButton(
                  context,
                  'Food Diary',
                  Icons.book,
                  onPressed: () {
                    debugPrint('Food diary button pressed');
                  },
                ),
                const SizedBox(height: 16),
                _buildFeatureButton(
                  context,
                  'Recipes',
                  Icons.restaurant_menu,
                  onPressed: () {
                    debugPrint('Recipes button pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    String label,
    IconData icon, {
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}