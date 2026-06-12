import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipeapp/constants/app_colors.dart';

import 'package:recipeapp/view/pages/home_screen.dart';
import 'package:recipeapp/view/pages/recipes_list_screen.dart';
import 'package:recipeapp/viewModel/favorite_controller.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favRecipeProvider);
    final List pages = [
      HomeScreen(),
      RecipeListScreen(title: 'Favorites', recipes: favorites),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.secondary,
        elevation: 4,
        enableFeedback: true,
        unselectedItemColor: AppColors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
