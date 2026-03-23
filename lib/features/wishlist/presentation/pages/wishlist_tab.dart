import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/wishlist_grid_widget.dart';
import 'package:flutter/material.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: "Wishlist",
          centerTitle: true,
          showBackButton: false,
        ),
        WishlistGridWidget(),
      ],
    );
  }
}
