class CheckoutModel {
  final double total;
  final List<CheckoutItemModel> items;

  CheckoutModel({required this.total, required this.items});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      total: double.parse(json["total"].toString()),
      items: (json["cart_items"] as List)
          .map((e) => CheckoutItemModel.fromJson(e))
          .toList(),
    );
  }
}

class CheckoutItemModel {
  final String name;
  final double price;
  final int quantity;
  final double total;

  CheckoutItemModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) {
    return CheckoutItemModel(
      name: json["item_product_name"],
      price: double.parse(json["item_product_price"]),
      quantity: json["item_quantity"],
      total: double.parse(json["item_total"]),
    );
  }
}
