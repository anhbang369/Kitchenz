import 'dart:convert';
import 'dart:io';

import 'package:firstapp/models/category_post_view_model.dart';
import 'package:firstapp/models/category_model.dart';
import 'package:firstapp/models/deal_model.dart';
import 'package:firstapp/models/deal_view_model.dart';
import 'package:firstapp/models/ingredient_model.dart';
import 'package:firstapp/models/nutrition_model.dart';
import 'package:firstapp/models/user_model.dart';
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
      return dish;
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
      final list = List<CategoryPostViewModel>.from(
          data.map((json) => CategoryPostViewModel.fromJson(json)));
      return list;
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
    Map<String, dynamic> body = {
      'ingredients': ids.map((id) => id.toString()).toList()
    };
    final response = await http.post(
      Uri.parse('$_baseUrl/ingredient/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<DishModel>.from(data.map((json) => DishModel.fromJson(json)));
    } else {
      throw Exception('Failed to load dish');
    }
  }

  // Get routine list
  static Future<List<DealModel>> getRoutineList() async {
    final response = await http.get(Uri.parse('$_baseUrl/routine/list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      List<DealModel> list =
          List<DealModel>.from(data.map((json) => DealModel.fromJson(json)));
      return list;
    } else {
      throw Exception('Failed to load routine');
    }
  }

  // Get deal detail
  static Future<DealViewModel> getDealDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/routine/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return DealViewModel.fromJson(data);
    } else {
      throw Exception('Failed to load deal');
    }
  }

  // Login
  static Future<UserModel> login(String email, String uid) async {
    // body
    Map<String, dynamic> body = {
      'email': email,
      'uid': uid,
    };
    final response = await http.post(
      Uri.parse('$_baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      UserModel user = UserModel.fromJson(data);
      return storeUser(user);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<UserModel> storeUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userUid', user.uid);
    await prefs.setString('imageUrl', user.imageUrl);
    await prefs.setBool('isUserVip', user.isVip);
    await prefs.setString('username', user.username);
    await prefs.setString('phone', user.phone);
    await prefs.setString('address', user.address);
    return user;
  }

  static Future<UserModel?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? userEmail = prefs.getString('userEmail');
    String? userUid = prefs.getString('userUid');
    String? imageUrl = prefs.getString('imageUrl');
    bool? isUserVip = prefs.getBool('isUserVip');
    String? username = prefs.getString('username');
    String? phone = prefs.getString('phone');
    String? address = prefs.getString('address');

    if (id != null &&
        userEmail != null &&
        userUid != null &&
        isUserVip != null &&
        imageUrl != null &&
        username != null &&
        phone != null &&
        address != null) {
      return UserModel(
        id: id,
        email: userEmail,
        uid: userUid,
        imageUrl: imageUrl,
        isVip: isUserVip,
        username: username,
        phone: phone,
        address: address,
      );
    } else {
      return null;
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userUid');
    await prefs.remove('isUserVip');
  }

  // Update vip status
  static Future<UserModel> updateVip() async {
    UserModel? user = await getCurrentUser();
    if (user != null) {
      final String uid = user.uid;
      final response =
          await http.get(Uri.parse('$_baseUrl/user/success-payment/$uid'));
      if (response.statusCode == 200) {
        user.isVip = true;
        return storeUser(user);
      } else {
        throw Exception('Failed to update vip');
      }
    } else {
      throw Exception('Failed to update vip');
    }
  }

  static Future<bool> likeDish(int userId, int dishId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'dishId': dishId,
    };
    final response = await http.post(
      Uri.parse('$_baseUrl/dish/like'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to like dish');
    }
  }

  static Future<List<DishModel>> getLikedDish(int userId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/dish/get-liked-dish/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.body.runes.toList()));
      return List<DishModel>.from(data.map((json) => DishModel.fromJson(json)));
    } else {
      throw Exception('Failed to load dish');
    }
  }

  static Future<bool> comment(int dishId, String description) async {
    // Get current user
    UserModel? user = await getCurrentUser();
    if (user != null) {
      Map<String, dynamic> body = {
        'userId': user.id,
        'dishId': dishId,
        'description': description,
      };
      final response = await http.post(
        Uri.parse('$_baseUrl/comment/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to comment');
      }
    } else {
      throw Exception('Failed to comment');
    }
  }

  static Future<UserModel> updateUser(String username, String email,
      String address, String phone, String imageUrl) async {
    UserModel? user = await getCurrentUser();
    if (user != null) {
      if (username != '') user = user.copyWith(username: username);
      if (email != '') user = user.copyWith(email: email);
      if (address != '') user = user.copyWith(address: address);
      if (phone != '') user = user.copyWith(phone: phone);
      if (imageUrl != '') user = user.copyWith(imageUrl: imageUrl);
      final response = await http.post(
        Uri.parse('$_baseUrl/user/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return storeUser(user);
      } else {
        throw Exception('Failed to update user');
      }
    } else {
      throw Exception('Failed to update user');
    }
  }
}
