part of 'slider_cubit.dart';

abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderSuccess extends SliderState {
  final List<SliderModel> sliders;

  SliderSuccess(this.sliders);
}

class SliderError extends SliderState {
  final String message;

  SliderError(this.message);
}
