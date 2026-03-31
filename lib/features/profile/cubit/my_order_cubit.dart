import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../models/my_order_model.dart';

class MyOrderCubit extends Cubit<MyOrderModel?> {
  final ApiClient api = ApiClient();

  MyOrderCubit() : super(null);

  Future<void> fetchMyOrder() async {
    try {
      final response = await api.get(ApiConstants.orderHistory);

      final data = response.data["data"];

      emit(MyOrderModel.fromJson(data));
    } catch (e) {
      print("MyOrder ERROR: $e");
    }
  }
}
