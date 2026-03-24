import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../home/data/models/product_model.dart';
import '../../../wishlist/cubit/wishlist_cubit.dart';
import '../../../wishlist/cubit/wishlist_state.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            onBackPressed: () {
              Navigator.pop(context);
            },
            actions: [
              BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, state) {
                  bool isFavorite = false;

                  if (state is WishlistLoaded) {
                    isFavorite = state.items.any((e) => e.id == product.id);
                  }

                  return IconButton(
                    onPressed: () {
                      if (isFavorite) {
                        context.read<WishlistCubit>().removeFromWishlist(
                          product.id,
                        );
                      } else {
                        context.read<WishlistCubit>().addToWishlist(product.id);
                      }
                    },
                    icon: SvgPicture.asset(
                      Assets.iconsWishlist,
                      height: 20.h,
                      width: 17.w,
                      colorFilter: ColorFilter.mode(
                        isFavorite ? Colors.red : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(22.w),
              child: Column(
                crossAxisAlignment: .center,
                mainAxisSize: .max,
                mainAxisAlignment: .center,
                children: [
                  // book image
                  Container(
                    height: 271.h,
                    width: 183.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                    ),
                    child: Image.network(product.image, fit: BoxFit.fill),
                  ),
                  SizedBox(height: 11.h),
                  // book name
                  Text(
                    product.name,
                    style: AppTextStyles.playfairDisplayLarge(
                      context,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 11.h),

                  // book Category
                  Text(
                    product.category,
                    style: AppTextStyles.playfairDisplayLarge(
                      context,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: AppColors.primary_button_color,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // book description
                  Text(
                    product.description,
                    style: AppTextStyles.playfairDisplayLarge(
                      context,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 59.h),
                  // book price and add to cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: .max,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: AppTextStyles.playfairDisplayLarge(
                          context,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 24.sp,
                          color: AppColors.black,
                        ),
                      ),
                      CustomButton(
                        text: LocaleKeys.add_to_cart.tr(),
                        color: AppColors.black,
                        textColor: AppColors.white,
                        width: 212.w,
                        height: 56.h,
                        onPressed: () {
                          context.read<CartCubit>().addToCart(product.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to cart")),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
