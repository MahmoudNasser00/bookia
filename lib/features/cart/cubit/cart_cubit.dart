import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/cart_item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiClient api = ApiClient();

  CartCubit() : super(CartInitial());

  /// Get Cart
  Future<void> fetchCart() async {
    try {
      emit(CartLoading());

      final response = await api.get(ApiConstants.cart);

      final items = (response.data["data"]["cart_items"] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList();

      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// Add To Cart
  Future<void> addToCart(int productId) async {
    try {
      await api.post(ApiConstants.addToCart, data: {"product_id": productId});

      fetchCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// Update Quantity
  Future<void> updateCart(int cartItemId, int quantity) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItemModel>.from(
        (state as CartLoaded).items,
      );

      final index = currentItems.indexWhere((e) => e.id == cartItemId);

      if (index != -1) {
        currentItems[index] = CartItemModel(
          id: currentItems[index].id,
          productId: currentItems[index].productId,
          name: currentItems[index].name,
          image: currentItems[index].image,
          price: currentItems[index].price,
          quantity: quantity,
        );

        emit(CartLoaded(currentItems));
      }
    }

    /// API request
    await api.post(
      ApiConstants.updateCart,
      data: {"cart_item_id": cartItemId, "quantity": quantity},
    );
  }

  /// Remove Item
  Future<void> removeFromCart(int cartItemId) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItemModel>.from(
        (state as CartLoaded).items,
      );

      currentItems.removeWhere((e) => e.id == cartItemId);

      emit(CartLoaded(currentItems));
    }

    await api.post(
      ApiConstants.removeFromCart,
      data: {"cart_item_id": cartItemId},
    );
  }
}
