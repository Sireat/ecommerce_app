import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import 'product_details_screen.dart';

/// Screen that displays a list of products.
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductRepositoryImpl _repository = ProductRepositoryImpl();
  late Future<List<ProductEntity>> _products;

  @override
  void initState() {
    super.initState();
    _products = _repository.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 24, // Adjusted for better responsiveness
                color: Color.fromARGB(255, 22, 21, 21),
              ),
            ),
            Text(
              'Super summer sale',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 12, // Adjusted for better responsiveness
                color: Color.fromARGB(255, 112, 106, 106),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<ProductEntity>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0), // Added padding for responsiveness
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.08),
                      child: Row(
                        children: [
                          // Left side: Image
                          Flexible(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 1, // Maintain square aspect ratio
                              child: Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: product.image.isNotEmpty
                                      ? Stack(
                                          children: [
                                            // Product image
                                            Image.network(
                                              product.image,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return const Icon(Icons.error, size: 50);
                                              },
                                            ),
                                            // Discount percentage label
                                            if (product.discountPercentage > 0) // Show only if there's a discount
                                              Positioned(
                                                top: 8,
                                                left: 8,
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    '-${product.discountPercentage.toStringAsFixed(1)}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                      : const Icon(Icons.image, size: 100),
                                ),
                              ),
                            ),
                          ),
                          // Right side: Title, Rating, and Price
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Rating
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (index) {
                                          double starValue = product.rating - index;
                                          if (starValue >= 1) {
                                            return const Icon(Icons.star, color: Colors.amber, size: 16);
                                          } else if (starValue >= 0.5) {
                                            return const Icon(Icons.star_half, color: Colors.amber, size: 16);
                                          } else {
                                            return const Icon(Icons.star_border, color: Colors.amber, size: 16);
                                          }
                                        }),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${product.rating.toStringAsFixed(1)})',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.category.isNotEmpty
                                        ? product.category
                                        : 'No category available',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.title.isNotEmpty
                                        ? product.title
                                        : 'No title available',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '\$${product.price.toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '\$${(product.price * (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.red,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}