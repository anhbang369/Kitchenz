import 'package:firstapp/models/comment_model.dart';
import 'package:firstapp/models/view_detail_step_model.dart';

class DishModel {
  final int id;
  final String name;
  final String description;
  final int viewNumber;
  final double duration;
  final String status;
  final String imageUrl;
  final bool isVip;
  final List<CommentModel> comments;
  final List<String> likes;
  final List<ViewDetailStepModel> steps;
  final List<NutritionDish> nutritionDishs;
  final List<IngredientDish> ingredientDishs;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.viewNumber,
    required this.duration,
    required this.status,
    required this.imageUrl,
    required this.isVip,
    required this.likes,
    required this.comments,
    required this.steps,
    required this.nutritionDishs,
    required this.ingredientDishs,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    // Check if json['steps']['status'] not deactive
    // json['steps'] = json['steps']
    //     .where((step) => step['status'] == 'ACTIVE')
    //     .toList(growable: false);

    List<Map<String, dynamic>> likesData =
        List<Map<String, dynamic>>.from(json['likes']);
    List<String> likes = likesData
        .where((like) => like['status'] == 'ACTIVE')
        .map((like) => like['user']['id'].toString())
        .toList(growable: false);
    List<CommentModel> commentsList = json['comments'] != null
        ? (json['comments'] as List)
            .map((comment) => CommentModel.fromJson(comment))
            .toList()
        : [];
    return DishModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      viewNumber: json['viewNumber'],
      duration: double.parse(json['duration']),
      status: json['status'],
      imageUrl: json['imageUrl'],
      isVip: json['isVip'],
      likes: likes,
      comments: commentsList,
      steps: List<ViewDetailStepModel>.from(
          json['steps'].map((x) => ViewDetailStepModel.fromJson(x))),
      nutritionDishs: List<NutritionDish>.from(
          json['nutritionDishs'].map((nd) => NutritionDish.fromJson(nd))),
      ingredientDishs: List<IngredientDish>.from(
          json['ingredientDishs'].map((id) => IngredientDish.fromJson(id))),
    );
  }
}

class Nutrition {
  final int id;
  final String name;
  final String unit;

  Nutrition(
    this.id,
    this.name,
    this.unit,
  );
  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      json['id'],
      json['name'],
      json['unit'],
    );
  }
}

class NutritionDish {
  final int id;
  final Nutrition nutrition;
  final double amount;

  NutritionDish(
    this.id,
    this.nutrition,
    this.amount,
  );

  factory NutritionDish.fromJson(Map<String, dynamic> json) {
    return NutritionDish(
      json['id'],
      Nutrition.fromJson(json['nutrition']),
      json['amount'],
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String unit;

  Ingredient(
    this.id,
    this.name,
    this.unit,
  );

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      json['id'],
      json['name'],
      json['unit'],
    );
  }
}

class IngredientDish {
  final int id;
  final Ingredient ingredient;
  final double amount;

  IngredientDish(
    this.id,
    this.ingredient,
    this.amount,
  );

  factory IngredientDish.fromJson(Map<String, dynamic> json) {
    return IngredientDish(
      json['id'],
      Ingredient.fromJson(json['ingredient']),
      json['amount'],
    );
  }
}
