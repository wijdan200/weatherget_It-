class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';
  
  static String getProductsUrl({int? limit}) {
    if (limit != null) {
      return '$baseUrl$productsEndpoint?limit=$limit';
    }
    return '$baseUrl$productsEndpoint';
  }
}

enum SortType { name, price }



