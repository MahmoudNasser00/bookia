class CartItemModel {
  final int id;
  final int productId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["item_id"],
      productId: json["item_product_id"],
      name: json["item_product_name"],
      image: json["item_product_image"],
      price: double.tryParse(json["item_product_price"].toString()) ?? 0,
      quantity: json["item_quantity"] ?? 1,
    );
  }
}
