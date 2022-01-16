import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_converter.dart';
import 'model_response.dart';
import 'service_interface.dart';

part 'recipe_service.chopper.dart';

const String apiKey = '48bc65493e651396d3e02799a8c9bda6';
const String apiId = '79e45cca';
const String apiUrl = 'https://api.edamam.com';

@ChopperApi()
abstract class RecipeService extends ChopperService implements ServiceInterface {
  @override
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query, @Query('from') int from, @Query('to') int to);
  //TODO: Add create
  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [_$RecipeService()],
    );

    return _$RecipeService(client);
  }
}

//TODO: Add _addQuery
Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);

  //Add apiId and apiKey to request parameters
  params['app_id'] = apiId;
  params['app_key'] = apiKey;

  //Return new copy of the request with the params
  return req.copyWith(parameters: params);
}
