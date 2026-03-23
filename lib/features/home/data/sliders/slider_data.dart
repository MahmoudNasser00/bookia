import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../models/slider_model.dart';

class SliderDataSource {
  final ApiClient api;

  SliderDataSource(this.api);

  Future<List<SliderModel>> getSliders() async {
    final response = await api.get(ApiConstants.sliders);

    final List data = response.data["data"];

    return data.map((e) => SliderModel.fromJson(e)).toList();
  }
}
