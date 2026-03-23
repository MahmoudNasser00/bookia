import 'package:bookia/features/search/data/cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search_data_source.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchDataSource data;

  SearchCubit(this.data) : super(SearchInitial());

  Future<void> search(String name) async {
    emit(SearchLoading());

    try {
      final result = await data.searchProducts(name);
      emit(SearchSuccess(result));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
