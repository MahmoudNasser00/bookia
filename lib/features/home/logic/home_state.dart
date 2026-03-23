part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<SliderModel> sliders;
  final List<CategoryModel> categories;
  final List<ProductModel> bestSeller;

  HomeSuccess({
    required this.sliders,
    required this.categories,
    required this.bestSeller,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
