import 'package:bookia/core/network/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../data/order_repository.dart';
import '../models/checkout_model.dart';
import '../models/governorate_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository repo = OrderRepository(ApiClient());

  OrderCubit() : super(OrderInitial());

  /// place order
  Future<bool> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    try {
      emit(OrderLoading());

      await repo.placeOrder(
        governorateId: governorateId,
        name: name,
        phone: phone,
        address: address,
        email: email,
      );

      emit(OrderSuccess());
      return true;
    } catch (e) {
      emit(OrderError(e.toString()));
      return false;
    }
  }

  /// order history
  Future<void> getOrders() async {
    try {
      emit(OrderLoading());

      final orders = await repo.getOrders();

      emit(OrderHistoryLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  /// checkout

  CheckoutModel? checkout;

  Future<void> getCheckout() async {
    try {
      emit(OrderLoading());

      checkout = await repo.getCheckout();

      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  /// Governorate
  Future<List<GovernorateModel>> getGovernorates() async {
    try {
      final response = await ApiClient().get(ApiConstants.governorates);
      final list = (response.data["data"] as List)
          .map((e) => GovernorateModel.fromJson(e))
          .toList();

      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
