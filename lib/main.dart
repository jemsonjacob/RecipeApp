import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipeapp/constants/app_colors.dart';
import 'package:recipeapp/view/pages/splash_screen.dart';
import 'package:recipeapp/viewModel/theme_controller.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecipeHub',
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      themeMode: themeMode.value ?? ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
