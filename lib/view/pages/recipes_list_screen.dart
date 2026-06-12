import 'package:flutter/material.dart';
import 'package:recipeapp/view/pages/recipe_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:recipeapp/model/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  final String title;
  final List<Recipe> recipes;

  const RecipeListScreen({
    super.key,
    required this.title,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: recipes.isNotEmpty
          ? ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(recipe),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Hero(
                            tag: recipe.id, //a unique value is needed
                            child: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(recipe.image),
                              fit: BoxFit.cover,
                              height: 220,
                              width: double.infinity,
                              fadeInDuration: const Duration(milliseconds: 800),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.surface.withValues(alpha: 0.5),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  spacing: 15,
                                  children: [
                                    Text(
                                      recipe.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Uh oh .. Nothing there to show",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
    );
  }
}
