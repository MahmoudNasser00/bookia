import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../home/data/models/product_model.dart';

class SearchDataSource {
  final ApiClient api;

  SearchDataSource(this.api);
  Future<List<ProductModel>> searchProducts(String name) async {
    final res = await api.get(ApiConstants.search, query: {"name": name});

    final List data = res.data["data"]?["products"] ?? [];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
