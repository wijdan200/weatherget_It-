import '../models/product_model.dart';
import 'package:flutter_application/core/network/api_client.dart';
import 'package:flutter_application/core/constants/api_constants.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int? limit});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({int? limit}) async {
    try {
      final endpoint = limit != null 
          ? '${ApiConstants.productsEndpoint}?limit=$limit'
          : ApiConstants.productsEndpoint;
      
      final data = await apiClient.getList(endpoint);
      
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}

