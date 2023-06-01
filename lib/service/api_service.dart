import 'dart:convert';

import '../models/dish_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://minh-prn.monoinfinity.net';

  // Fetch dish detail
  static Future<Dish> fetchDishDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/dish/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return Dish.fromJson(data);
    } else {
      throw Exception('Failed to load dish');
    }
  }
}
