// lib/domain/usecases/get_products.dart

import 'package:ecommerce_app/data/models/product_model.dart';

import '../repositories/product_repository.dart';

/// Use case for fetching the list of products.
class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  /// Executes the use case to fetch products from the repository.
  Future<List<ProductEntity>> call() async {
    return await repository.fetchProducts();
  }
}
