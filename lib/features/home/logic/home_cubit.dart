import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/home_data_source.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/models/slider_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeDataSource data;

  HomeCubit(this.data) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());

    try {
      final sliders = await data.getSliders();

      final categories = await data.getCategories();

      final bestSeller = await data.getBestSeller();

      emit(
        HomeSuccess(
          sliders: sliders,
          categories: categories,
          bestSeller: bestSeller,
        ),
      );
    } catch (e, stacktrace) {
      emit(HomeError(e.toString()));
    }
  }
}
