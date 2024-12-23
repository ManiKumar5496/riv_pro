// lib/home/data/api/home_api_service.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../app/api/api_constants.dart';
import '../model/product_model.dart';

class HomeApiService {
  HomeApiService();

  Future<ProductsScreen> fetchHomeData() async {
    final response = await http.get(Uri.parse(ApiConstants.products));

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of HomeModel objects
      return ProductsScreen.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
