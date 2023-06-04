import 'dart:convert';
import 'dart:io';

import 'package:firstapp/models/category_post_view_model.dart';
import 'package:firstapp/models/category_model.dart';
import 'package:firstapp/models/ingredient_model.dart';
import 'package:firstapp/models/nutrition_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dish_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://minh-prn.monoinfinity.net';

  // Fetch dish detail
  static Future<DishModel> fetchDishDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/dish/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      DishModel dish = DishModel.fromJson(data);
      return getNutritionListLocally().then((nutritionsData) {
        // for each nutritionDish, get nutrition data by id then set name and unit
        for (var nd in dish.nutritionDishs) {
          for (var n in nutritionsData) {
            if (nd.id == n.id) {
              nd.name = n.name;
              nd.unit = n.unit;
            }
          }
        }
        return getIngredientListLocally().then((ingredientsData) {
          for (var id in dish.ingredientDishs) {
            for (var i in ingredientsData) {
              if (id.id == i.id) {
                id.name = i.name;
                id.unit = i.unit;
              }
            }
          }
          return dish;
        });
      });
    } else {
      throw Exception('Failed to load dish');
    }
  }

  // Fetch category list
  static Future<List<CategoryModel>> fetchCategoryList() async {
    final response = await http.get(Uri.parse('$_baseUrl/category/list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<CategoryModel>.from(
          data.map((json) => CategoryModel.fromJson(json)));
    } else {
      throw Exception('Failed to load category');
    }
  }

  // Fetch dish of category
  static Future<List<CategoryPostViewModel>> fetchDishOfCategory(int id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/category/dish-of-category/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<CategoryPostViewModel>.from(
          data.map((json) => CategoryPostViewModel.fromJson(json)));
    } else {
      throw Exception('Failed to load dish');
    }
  }

  // Fetch nutrition list
  static Future<List<NutritionModel>> fetchNutritionList() async {
    final response = await http.get(Uri.parse('$_baseUrl/nutrition/list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<NutritionModel>.from(
          data.map((json) => NutritionModel.fromJson(json)));
    } else {
      throw Exception('Failed to load nutrition');
    }
  }

  // Fetch ingredient list
  static Future<List<IngredientModel>> fetchIngredientList() async {
    final response = await http.get(Uri.parse('$_baseUrl/ingredient/list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<IngredientModel>.from(
          data.map((json) => IngredientModel.fromJson(json)));
    } else {
      throw Exception('Failed to load ingredient');
    }
  }

  // Get nutrition list locally
  static Future<List<NutritionModel>> getNutritionListLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('nutritionsData');
    if (data != null) {
      final nutritionList = jsonDecode(data);
      return List<NutritionModel>.from(
        nutritionList.map((json) => NutritionModel.fromJson(json)),
      );
    } else {
      // Get nutrition list from server
      final nutritionList = await fetchNutritionList();
      List<Map<String, dynamic>> nutritionListJson =
          nutritionList.map((nutrition) => nutrition.toJson()).toList();
      prefs.setString('nutritionsData', json.encode(nutritionListJson));
      return nutritionList;
    }
  }

  // Get ingredient list locally
  static Future<List<IngredientModel>> getIngredientListLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('ingredientsData');
    if (data != null) {
      final ingredientList = jsonDecode(data);
      return List<IngredientModel>.from(
        ingredientList.map((json) => IngredientModel.fromJson(json)),
      );
    } else {
      // Get ingredient list from server
      final ingredientList = await fetchIngredientList();
      List<Map<String, dynamic>> ingredientListJson =
          ingredientList.map((ingredient) => ingredient.toJson()).toList();
      prefs.setString('ingredientsData', json.encode(ingredientListJson));
      return ingredientList;
    }
  }

  // Get top 5 dish
  static Future<List<DishModel>> getTop5Dish() async {
    final response = await http.get(Uri.parse('$_baseUrl/dish/get-top-5'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<DishModel>.from(data.map((json) => DishModel.fromJson(json)));
    } else {
      throw Exception('Failed to load dish');
    }
  }

  // Get dish by ingredient id
  static Future<List<DishModel>> getDishByIngredientId(List<int> ids) async {
    final idList = ids.join(',');
    final uri = Uri.http(_baseUrl, "/ingredient/search",
        jsonEncode(idList) as Map<String, dynamic>?);
    final header = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<DishModel>.from(data.map((json) => DishModel.fromJson(json)));
    } else {
      throw Exception('Failed to load dish');
    }
  }
}
