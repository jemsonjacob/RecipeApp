import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipeapp/model/recipe.dart';

class FavNotifier extends Notifier<List<Recipe>> {
  @override
  List<Recipe> build() {
    return [];
  }

  bool toogleFav(Recipe recipe) {
    final isRecipeFav = state.contains(recipe);

    if (isRecipeFav) {
      state = state.where((e) => e.id != recipe.id).toList();

      return false;
    } else {
      state = [...state, recipe];
      return true;
    }
  }
}

final favRecipeProvider = NotifierProvider<FavNotifier, List<Recipe>>(
  () => FavNotifier(),
);
