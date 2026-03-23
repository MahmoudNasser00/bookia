import 'package:bookia/core/network/api_client.dart';
import 'package:bookia/core/network/api_constants.dart';

import 'models/product_model.dart';
import 'models/category_model.dart';
import 'models/slider_model.dart';

class HomeDataSource {
  final ApiClient api;

  HomeDataSource(this.api);

  /// Sliders
  Future<List<SliderModel>> getSliders() async {
    final res = await api.get(ApiConstants.sliders);

    final List data = res.data["data"]["sliders"] ?? [];
    return data.map((e) => SliderModel.fromJson(e)).toList();
  }

  /// Best Seller
  Future<List<ProductModel>> getBestSeller() async {
    final res = await api.get(ApiConstants.bestSeller);

    final List data = res.data["data"]["products"] ?? [];

    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  /// Categories
  Future<List<CategoryModel>> getCategories() async {
    final res = await api.get(ApiConstants.categories);

    List data = [];

    if (res.data["data"] is List) {
      data = res.data["data"];
    } else if (res.data["data"]["categories"] != null) {
      data = res.data["data"]["categories"];
    } else if (res.data["data"]["products"] != null) {
      // If categories endpoint returns products (unlikely but possible)
      data = res.data["data"]["products"];
    } else {
      data = [];
    }

    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
