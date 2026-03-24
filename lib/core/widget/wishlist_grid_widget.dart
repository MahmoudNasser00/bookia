import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/features/home/data/models/product_model.dart';
import 'package:bookia/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/cubit/wishlist_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../generated/assets.dart';
import '../localization/generated/locale_keys.g.dart';

class WishlistGridWidget extends StatelessWidget {
  const WishlistGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final isLoading = state is WishlistLoading || state is WishlistInitial;
        final items = state is WishlistLoaded ? state.items : [];

        /// Empty State
        if (!isLoading && items.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                LocaleKeys.No_items_in_favorites.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                  color: AppColors.black,
                ),
              ),
            ),
          );
        }

        final books = items
            .map(
              (item) => ProductModel(
                id: item.id,
                name: item.name,
                image: item.image,
                price: double.tryParse(item.price) ?? 0,
                category: item.category,
                description: item.description,
              ),
            )
            .toList();

        final displayItems = isLoading ? List.generate(6, (_) => null) : books;

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 11.w,
              mainAxisSpacing: 30.h,
              childAspectRatio: .5,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = displayItems[index];

              return Skeletonizer(
                enabled: isLoading,
                child: Container(
                  key: ValueKey(product?.id ?? index),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade300,
                            ),
                            child: product == null
                                ? const SizedBox()
                                : Image.network(
                                    product.image,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        product?.name ?? "Book Name",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.playfairDisplayLarge(
                          context,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product == null ? "0" : "${product.price}",
                            style: AppTextStyles.playfairDisplayLarge(
                              context,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                              color: AppColors.black,
                            ),
                          ),

                          IconButton(
                            onPressed: product == null
                                ? null
                                : () {
                                    context
                                        .read<WishlistCubit>()
                                        .removeFromWishlist(product.id);
                                  },
                            icon: SvgPicture.asset(
                              Assets.iconsWishlist,
                              height: 20.h,
                              width: 17.w,
                              colorFilter: const ColorFilter.mode(
                                Colors.red,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: displayItems.length),
          ),
        );
      },
    );
  }
}
