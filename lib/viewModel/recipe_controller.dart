import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipeapp/model/recipe.dart';
import 'package:recipeapp/services/api_services.dart';

final apiServiceProvider = Provider((ref) {
  return ApiServices();
});

final recipeProvider = FutureProvider<List<Recipe>>((ref) async {
  final apiServices = ref.read(apiServiceProvider);
  return apiServices.fetchRecipes();
});
