import 'models/models.dart';

abstract class Repository {
  //TODO: Add find methods
  Future<List<Recipe>> findAllRecipes();

  Stream<List<Recipe>> watchAllRecipes();

  Future<Recipe> findRecipeById(int id);

  Future<List<Ingredient>> findAllIngredients();

  Stream<List<Ingredient>> watchAllIngredients();

  Future<List<Ingredient>> findRecipeIngredients(int recipeId);

  //TODO: Add insert methods
  Future<int> insertRecipe(Recipe recipe);

  Future<List<int>> insertIngredients(List<Ingredient> ingredients);

  //TODO: Add delete methods
  Future<void> deleteRecipe(Recipe recipe);

  Future<void> deleteIngredient(Ingredient ingredient);

  Future<void> deleteIngredients(List<Ingredient> ingredients);

  Future<void> deleteRecipeIngredients(int recipeId);

  //TODO: Add intializing and closing methods
  // Allow repository to initiliaze - e.g. DB start
  Future init();

  void close();
}
