import 'dart:convert';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'model_response.dart';
import 'recipe_model.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    //Add application/json headers to request
    final req =
        applyHeader(request, contentTypeKey, jsonHeaders, override: false);

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    //Extract content type from request headers
    final contentType = request.headers[contentTypeKey];

    //Confirm content type is of type JSON
    if (contentType != null && contentType.contains(jsonHeaders)) {
      //Return encode copy of request
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;

    //Check if content is JSON and decode response into a string
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }

    try {
      //JSON decode to convert string into Map representation
      final mapData = json.decode(body);

      //Check if status field exists. Indicates the server encountered an error
      if (mapData['status'] != null) {
        return response.copyWith<BodyType>(
            body: Error(Exception(mapData['status'])) as BodyType);
      }

      //Convert Map into model class
      final recipeQuery = APIRecipeQuery.fromJson(mapData);
      //return successful response that wraps recipeQuery
      return response.copyWith<BodyType>(
          body: Success(recipeQuery) as BodyType);
    } catch (e) {
      chopperLogger.warning(e);
      // Wrap any other kind of error with generic instance of Error
      return response.copyWith<BodyType>(
          body: Error(e as Exception) as BodyType);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
