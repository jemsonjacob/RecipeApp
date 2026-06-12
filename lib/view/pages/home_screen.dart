import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipeapp/constants/app_colors.dart';
import 'package:recipeapp/constants/category_colors.dart';
import 'package:recipeapp/view/pages/recipes_list_screen.dart';
import 'package:recipeapp/viewModel/recipe_controller.dart';
import 'package:recipeapp/viewModel/theme_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final recipes = ref.watch(recipeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("RecipeHub"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: recipes.when(
        data: (recipes) {
          final cuisines = recipes
              .map((recipe) => recipe.cuisine)
              .toSet()
              .toList();
          //show categories
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: cuisines.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    final selectedCuisine = cuisines[index];
                    final filteredRecipes = recipes
                        .where((recipe) => recipe.cuisine == selectedCuisine)
                        .toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeListScreen(
                          title: cuisines[index],
                          recipes: filteredRecipes,
                        ),
                      ),
                    );
                  },
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          getCuisineColor(
                            cuisines[index],
                          ).withValues(alpha: 0.55),
                          getCuisineColor(
                            cuisines[index],
                          ).withValues(alpha: 0.95),
                        ],
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cuisines[index],
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("An Error has been occured}"));
        },
        loading: () {
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: AppColors.grey,
              size: 50,
            ),
          );
        },
      ),
    );
  }
}
