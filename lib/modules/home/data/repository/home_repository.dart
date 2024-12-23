// lib/home/data/repositories/home_repository.dart

import '../api/home_api_service.dart';
import '../model/product_model.dart';

class HomeRepository {
  final HomeApiService apiService;

  HomeRepository({required this.apiService});

  Future<ProductsScreen> getHomeData() async {
    try {
      return await apiService.fetchHomeData();
    } catch (e) {
      throw Exception('Failed to load home data: $e');
    }
  }
}
