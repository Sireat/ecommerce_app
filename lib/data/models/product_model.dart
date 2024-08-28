// lib/data/models/product_model.dart

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
