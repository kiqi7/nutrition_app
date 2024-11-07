// lib/app.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

class NutritionApp extends StatelessWidget {
  const NutritionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}