import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/products_search_grid_widget.dart';
import '../../../home/data/models/product_model.dart';
import '../../data/cubit/search_cubit.dart';
import '../../data/cubit/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),

          /// search field
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextfield(
                hintText: "Search books...",
                controller: controller,
                keyboardType: TextInputType.text,
                onSubmitted: (value) {
                  context.read<SearchCubit>().search(value);
                },
              ),
            ),
          ),

          /// results
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final books = state is SearchSuccess
                  ? state.books
                  : <ProductModel>[];

              final isLoading =
                  state is SearchLoading || state is SearchInitial;

              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(19.w),
                  child: ProductsSearchGridWidget(
                    books: books,
                    isLoading: isLoading,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
