// lib/data/models/product_model.dart

// Rename this class to ProductEntity if it’s used as such in your domain layer
class ProductEntity {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
