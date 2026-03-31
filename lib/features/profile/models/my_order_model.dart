class OrderModel {
  final int id;
  final String orderCode;
  final String orderDate;
  final String status;
  final String total;

  OrderModel({
    required this.id,
    required this.orderCode,
    required this.orderDate,
    required this.status,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      orderCode: json["order_code"],
      orderDate: json["order_date"],
      status: json["status"],
      total: json["total"],
    );
  }
}

class MyOrderModel {
  final List<OrderModel> orders;

  MyOrderModel({required this.orders});

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      orders: (json["orders"] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }
}
