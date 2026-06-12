import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipeapp/constants/app_colors.dart';
import 'package:recipeapp/model/recipe.dart';
import 'package:recipeapp/viewModel/favorite_controller.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  final Recipe recipe;
  const RecipeDetailsScreen(this.recipe, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favRecipeProvider);
    final isFavorite = favorites.any(
      (e) => e.id == recipe.id,
    ); //check if any element's id same as recipe id

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: recipe.id,
                child: Image.network(
                  recipe.image,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              _buildTimeRow(),
              Text(
                "Ingredients",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (final ingredient in recipe.ingredients)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "👉  $ingredient",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                "Steps",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < recipe.instructions.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        radius: 12,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          recipe.instructions[i],
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 10),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final isAdded = ref
                        .read(favRecipeProvider.notifier)
                        .toogleFav(recipe);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          isAdded
                              ? "${recipe.name} added to favorites"
                              : "${recipe.name} removed from favorites",
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(
                    isFavorite ? "Remove Favorite" : "Add to Favorites",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.darkBackground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: AppColors.black.withValues(alpha: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.timer),
                  Icon(Icons.people),
                  Icon(Icons.trending_up),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${recipe.cookTimeMinutes.toString()} min"),
                  Text("${recipe.servings.toString()} person"),
                  Text(recipe.difficulty.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
