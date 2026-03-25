class OrderModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final double total;

  OrderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      address: json["address"],
      total: double.tryParse(json["total"].toString()) ?? 0,
    );
  }
}
