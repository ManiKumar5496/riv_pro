import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api/home_api_service.dart';
import '../data/model/product_model.dart';
import '../data/repository/home_repository.dart';

final homeApiServiceProvider = Provider<HomeApiService>((ref) {
  return HomeApiService();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiService = ref.read(homeApiServiceProvider);
  return HomeRepository(apiService: apiService);
});

final homeDataProvider = FutureProvider<ProductsScreen>((ref) async {
  final repository = ref.read(homeRepositoryProvider);
  return await repository.getHomeData();
});
