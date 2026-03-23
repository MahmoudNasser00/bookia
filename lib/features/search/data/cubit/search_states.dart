import '../../../home/data/models/product_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> books;

  SearchSuccess(this.books);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
