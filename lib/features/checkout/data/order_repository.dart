import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/order_model.dart';

class OrderRepository {
  final ApiClient api;

  OrderRepository(this.api);

  /// place order
  Future<void> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    await api.post(
      ApiConstants.placeOrder,
      data: {
        "governorate_id": governorateId,
        "name": name,
        "phone": phone,
        "address": address,
        "email": email,
      },
    );
  }

  /// get order history
  Future<List<OrderModel>> getOrders() async {
    final response = await api.get(ApiConstants.orderHistory);

    final list = (response.data["data"] as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();

    return list;
  }

  /// get single order
  Future<dynamic> getSingleOrder(int id) async {
    final response = await api.get("${ApiConstants.orderHistory}/$id");
    return response.data["data"];
  }
}
