// lib/data/repositories/product_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product.dart';

/// A repository that handles fetching product data from the API.
class ProductRepositoryImpl {
  /// Fetches the list of products from the API.
  Future<List<ProductEntity>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsData = data['products'] ?? []; // Handle null values
      return productsData.map((json) => ProductEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
