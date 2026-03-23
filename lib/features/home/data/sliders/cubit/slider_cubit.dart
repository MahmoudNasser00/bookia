import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/slider_model.dart';
import '../slider_data.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final SliderDataSource data;

  SliderCubit(this.data) : super(SliderInitial());

  Future<void> getSliders() async {
    emit(SliderLoading());

    try {
      final sliders = await data.getSliders();
      emit(SliderSuccess(sliders));
    } catch (e) {
      emit(SliderError(e.toString()));
    }
  }
}
