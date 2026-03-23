import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/features/home/data/models/product_model.dart';
import 'package:bookia/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistGridWidget extends StatelessWidget {
  const WishlistGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final isLoading = state is WishlistLoading;

        final items = state is WishlistLoaded ? state.items : [];

        /// Skeleton Fake Data
        final skeletonItems = List.generate(6, (index) => null);

        return Skeletonizer(
          enabled: isLoading,
          child: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: .55,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = isLoading ? null : items[index];

                final product = item == null
                    ? null
                    : ProductModel(
                        id: item.id,
                        name: item.name,
                        image: item.image,
                        price: double.tryParse(item.price) ?? 0,
                        category: item.category,
                        description: item.description,
                      );

                return WishlistItemCard(product: product);
              }, childCount: isLoading ? skeletonItems.length : items.length),
            ),
          ),
        );
      },
    );
  }
}

class WishlistItemCard extends StatelessWidget {
  final ProductModel? product;

  const WishlistItemCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Image
        Expanded(
          child: InkWell(
            onTap: product == null
                ? null
                : () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.productDetails,
                      arguments: product,
                    );
                  },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
              ),
              child: product == null
                  ? const SizedBox()
                  : Image.network(product!.image, fit: BoxFit.fill),
            ),
          ),
        ),

        SizedBox(height: 6.h),

        /// Name
        Text(
          product?.name ?? "Book name",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.playfairDisplayLarge(
            context,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),

        SizedBox(height: 4.h),

        /// Price + Remove
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product == null ? "\$00" : "\$${product!.price}",
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
            IconButton(
              onPressed: product == null
                  ? null
                  : () {
                      context.read<WishlistCubit>().removeFromWishlist(
                        product!.id,
                      );
                    },
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
