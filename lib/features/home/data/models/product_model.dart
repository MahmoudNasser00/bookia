class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;

  final String image;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: double.tryParse(json["price"].toString()) ?? 0,

      image: json["image"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
