import 'package:dio/dio.dart';
import 'package:recipeapp/model/recipe.dart';

class ApiServices {
  Dio dio = Dio();
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Recipe>> fetchRecipes() async {
    final response = await dio.get('$_baseUrl/recipes');

    if (response.statusCode == 200) {
      //print(response.data);//here recepie is a map not list
      return (response.data['recipes'] as List)
          .map((e) => Recipe.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}
