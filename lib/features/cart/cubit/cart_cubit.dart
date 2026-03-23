import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';

class CartCubit extends Cubit<List<CartItemModel>> {
  final ApiClient api = ApiClient();

  CartCubit() : super([]);

  Future<void> fetchCart() async {
    final response = await api.get(ApiConstants.cart);

    final items = (response.data["data"] as List)
        .map((e) => CartItemModel.fromJson(e))
        .toList();

    emit(items);
  }
}