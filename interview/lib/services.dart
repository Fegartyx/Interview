import 'package:dio/dio.dart';

import 'Products.dart';

class Services {
  static Future<List<Product>> getProducts() async {
    var limit = 10;
    try {
      final response = await Dio()
          .get('https://dummyjson.com/products?limit=$limit&skip=10');
      if (response.statusCode == 200) {
        final data = response.data;
        final products = List<Product>.from(
          data['products'].map((product) => Product.fromJson(product)),
        );
        return products;
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
