import 'package:equatable/equatable.dart';
import 'ingredient.dart';

class Recipe extends Equatable {
  int? id;
  final String? label;
  final String? image;
  final String? url;

  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  Recipe(
      {this.id,
      this.label,
      this.image,
      this.url,
      this.ingredients,
      this.calories,
      this.totalTime,
      this.totalWeight});

  @override
  List<Object?> get props =>
      [label, image, url, calories, totalTime, totalWeight];
}
