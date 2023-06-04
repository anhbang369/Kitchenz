import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/category_post_view_model.dart';

class NetworkRequest {
  static const String url =
      'https://minh-prn.monoinfinity.net/category/dish-of-category/1';

  static List<CategoryPostViewModel> parsePost(String reponseBody) {
    var list = json.decode(reponseBody) as List<dynamic>;
    List<CategoryPostViewModel> posts =
        list.map((model) => CategoryPostViewModel.fromJson(model)).toList();
    return posts;
  }

  static Future<List<CategoryPostViewModel>> fetchPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("code dc 200");
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      print("code dc 400");
      throw Exception('Not Found');
    } else {
      print("code dc 500  ");
      throw Exception('Cant get post');
    }
  }
}

class NetworkRequest1 {
  static const String url =
      'https://minh-prn.monoinfinity.net/category/dish-of-category/2';

  static List<CategoryPostViewModel> parsePost(String reponseBody) {
    var list = json.decode(reponseBody) as List<dynamic>;
    List<CategoryPostViewModel> posts =
        list.map((model) => CategoryPostViewModel.fromJson(model)).toList();
    return posts;
  }

  static Future<List<CategoryPostViewModel>> fetchPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("code dc 200");
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      print("code dc 400");
      throw Exception('Not Found');
    } else {
      print("code dc 500  ");
      throw Exception('Cant get post');
    }
  }
}

class NetworkRequest2 {
  static const String url =
      'https://minh-prn.monoinfinity.net/category/dish-of-category/3';

  static List<CategoryPostViewModel> parsePost(String reponseBody) {
    var list = json.decode(reponseBody) as List<dynamic>;
    List<CategoryPostViewModel> posts =
        list.map((model) => CategoryPostViewModel.fromJson(model)).toList();
    return posts;
  }

  static Future<List<CategoryPostViewModel>> fetchPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("code dc 200");
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      print("code dc 400");
      throw Exception('Not Found');
    } else {
      print("code dc 500  ");
      throw Exception('Cant get post');
    }
  }
}

class NetworkRequest3 {
  static const String url =
      'https://minh-prn.monoinfinity.net/category/dish-of-category/4';

  static List<CategoryPostViewModel> parsePost(String reponseBody) {
    var list = json.decode(reponseBody) as List<dynamic>;
    List<CategoryPostViewModel> posts =
        list.map((model) => CategoryPostViewModel.fromJson(model)).toList();
    return posts;
  }

  static Future<List<CategoryPostViewModel>> fetchPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("code dc 200");
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      print("code dc 400");
      throw Exception('Not Found');
    } else {
      print("code dc 500  ");
      throw Exception('Cant get post');
    }
  }
}
