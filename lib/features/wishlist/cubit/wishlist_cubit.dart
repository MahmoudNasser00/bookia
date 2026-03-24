import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/wishlist_item_model.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final ApiClient api = ApiClient();

  WishlistCubit() : super(WishlistInitial());

  /// get wishlist
  Future<void> fetchWishlist() async {
    try {
      emit(WishlistLoading());

      final response = await api.get(ApiConstants.wishlist);

      final items = (response.data["data"]["data"] as List)
          .map((e) => WishlistItemModel.fromJson(e))
          .toList();

      emit(WishlistLoaded(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  /// add wishlist
  Future<void> addToWishlist(int productId) async {
    try {
      await api.post(
        ApiConstants.addToWishlist,
        data: {"product_id": productId},
      );

      await fetchWishlist();
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  /// remove wishlist
  Future<void> removeFromWishlist(int productId) async {
    try {
      if (state is WishlistLoaded) {
        final currentItems = List<WishlistItemModel>.from(
          (state as WishlistLoaded).items,
        );

        currentItems.removeWhere((item) => item.id == productId);

        emit(WishlistLoaded(currentItems));
      }

      await api.post(
        ApiConstants.removeFromWishlist,
        data: {"product_id": productId},
      );
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
