class ProductEntity {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image; // Primary image URL
  final double rating;
  final String category;
  final double discountPercentage;
  final String brand; // New brand property

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
    required this.discountPercentage,
    required this.brand, // Initialize brand in constructor
  });

  // Factory constructor to create a ProductEntity from JSON
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = List<String>.from(json['images'] ?? []);

    return ProductEntity(
      id: json['id']?.toString() ?? '', // Provide default value if null
      title: json['title'] ?? '', // Provide default value if null
      description: json['description'] ?? '', // Provide default value if null
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Provide default value if null
      image: imageUrls.isNotEmpty ? imageUrls.first : '', // Use the first image URL or default to empty string
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Provide default value if null
      category: json['category'] ?? '', // Provide default value if null
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0, // Provide default value if null
      brand: json['brand'] ?? '', // Provide default value if null
    );
  }
}
