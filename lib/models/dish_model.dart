import 'package:firstapp/models/nutrition_model.dart';
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
    required this.steps,
    required this.nutritionDishs,
    required this.ingredientDishs,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    // Check if json['steps']['status'] not deactive
    // json['steps'] = json['steps']
    //     .where((step) => step['status'] == 'ACTIVE')
    //     .toList(growable: false);
    return DishModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      viewNumber: json['viewNumber'],
      duration: double.parse(json['duration']),
      status: json['status'],
      imageUrl: json['imageUrl'],
      isVip: json['isVip'],
      steps: List<ViewDetailStepModel>.from(
          json['steps'].map((x) => ViewDetailStepModel.fromJson(x))),
      nutritionDishs: List<NutritionDish>.from(
          json['nutritionDishs'].map((nd) => NutritionDish.fromJson(nd))),
      ingredientDishs: List<IngredientDish>.from(
          json['ingredientDishs'].map((id) => IngredientDish.fromJson(id))),
    );
  }
}

class NutritionDish {
  final int id;
  final double amount;
  String unit = '';
  String name = '';
  NutritionDish({required this.id, required this.amount});

  factory NutritionDish.fromJson(Map<String, dynamic> json) {
    return NutritionDish(id: json['id'], amount: json['amount']);
  }
}

class IngredientDish {
  final int id;
  final double amount;
  String unit = '';
  String name = '';

  IngredientDish({required this.id, required this.amount});

  factory IngredientDish.fromJson(Map<String, dynamic> json) {
    return IngredientDish(id: json['id'], amount: json['amount']);
  }
}
