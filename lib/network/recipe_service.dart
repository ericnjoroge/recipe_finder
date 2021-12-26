import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_converter.dart';
import 'model_response.dart';

const String apiKey = '48bc65493e651396d3e02799a8c9bda6';
const String apiId = '79e45cca';
const String apiUrl = 'https://api.edamam.com/search';

@ChopperApi()
abstract class RecipeService extends ChopperService {
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query, @Query('from') int from, @Query('to') int to);
  //TODO: Add create
}

//TODO: Add _addQuery

// class RecipeService {
//   Future getData(String url) async {
//     print('Calling url: $url');
//     final response = await get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       print(response.statusCode);
//     }
//   }

//   Future<dynamic> getRecipes(String query, int from, int to) async {
//     final recipeData = getData(
//         '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');

//     return recipeData;
//   }
// }
