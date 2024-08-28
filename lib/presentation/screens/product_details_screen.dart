import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

/// Screen that displays detailed information about a product.
class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Main Product Image
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Flipped Image for Side View
                  Expanded(
                    flex: 3, // Adjust the flex to control the width ratio
                    child: Container(
                      color: const Color.fromARGB(255, 224, 222, 222),
                      child: Stack(
                        children: [
                          // Product Image
                          Center(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(3.14), // Flip horizontally
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                          ),
                          // Heart Icon for Bookmark
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border, color: Colors.red),
                              onPressed: () {
                                // Handle bookmark action here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Product Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            // Brand and Sale Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  Expanded(
                    child: Text(
                      product.brand.isNotEmpty ? product.brand : 'No brand available',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Sale Price
                  Text(
                    '\$${(product.price * (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
            // Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.category.isNotEmpty ? product.category : 'No category available',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Display star icons based on rating
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
                  // Display rating value in brackets
                  Text(
                    '(${product.rating.toStringAsFixed(1)})',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
