class CartItemModel {
  final int id;
  final int bookId;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.bookId,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["id"],
      bookId: json["book_id"],
      quantity: json["quantity"] ?? 1,
    );
  }
}