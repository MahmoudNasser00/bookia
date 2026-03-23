import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';

class BooksCubit extends Cubit<List<BookModel>> {
  final ApiClient api = ApiClient();

  BooksCubit() : super([]);

  Future<void> fetchBooks() async {
    try {
      final response = await api.get(ApiConstants.books);

      final books = (response.data["data"] as List)
          .map((e) => BookModel.fromJson(e))
          .toList();

      emit(books);
    } catch (_) {}
  }
}