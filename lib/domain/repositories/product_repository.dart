// lib/domain/repositories/product_repository.dart

import 'package:ecommerce_app/data/models/product_model.dart';


/// Abstract repository interface for fetching product data.
abstract class ProductRepository {
  /// Fetches the list of products.
  Future<List<ProductEntity>> fetchProducts();
}
