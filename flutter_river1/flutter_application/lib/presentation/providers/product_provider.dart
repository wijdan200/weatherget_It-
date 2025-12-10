import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/core/network/api_client.dart';
import 'package:flutter_application/core/constants/api_constants.dart';
import 'package:flutter_application/data/datasources/product_remote_datasource.dart';
import 'package:flutter_application/data/repositories/product_repository_impl.dart';
import 'package:flutter_application/domain/entities/product_entity.dart';

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    client: http.Client(),
    baseUrl: ApiConstants.baseUrl,
  );
});

// Data Source Provider
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
  );
});

// Repository Provider
final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.watch(productRemoteDataSourceProvider),
  );
});

// Main Product Provider
final productApiProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return await repository.getProducts(limit: 5);
});

