class WishlistItemModel {
  final int id;
  final String name;
  final String price;
  final String image;
  final String category;
  final String description;

  WishlistItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"]?.toString() ?? "",
      image: json["image"] ?? "",
      category: json["category"] ?? "",
      description: json["description"] ?? "",
    );
  }
}
