import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/features/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartGridWidget extends StatelessWidget {
  const CartGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isLoading = state is CartLoading || state is CartInitial;
        final items = state is CartLoaded ? state.items : [];

        if (!isLoading && items.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                "Cart is empty",
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

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = isLoading ? null : items[index];

              return Skeletonizer(
                enabled: isLoading,
                ignoreContainers: true,
                switchAnimationConfig: SwitchAnimationConfig(),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    children: [
                      /// Book Image
                      Container(
                        width: 70.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300,
                        ),
                        child: item == null
                            ? const SizedBox()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),

                      SizedBox(width: 12.w),

                      /// Book Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Title + Remove
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item?.name ?? "Book Name",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.playfairDisplayLarge(
                                      context,
                                      fontSize: 16.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),

                                /// remove
                                IconButton(
                                  onPressed: item == null
                                      ? null
                                      : () {
                                          context
                                              .read<CartCubit>()
                                              .removeFromCart(item.id);
                                        },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),

                            SizedBox(height: 6.h),

                            /// price
                            Text(
                              item == null ? "0" : "\$${item.price}",
                              style: AppTextStyles.playfairDisplayLarge(
                                context,
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            /// Quantity Controls
                            Row(
                              children: [
                                _qtyButton(
                                  icon: Icons.add,
                                  onTap: item == null
                                      ? null
                                      : () {
                                          context.read<CartCubit>().updateCart(
                                            item.id,
                                            item.quantity + 1,
                                          );
                                        },
                                ),

                                SizedBox(width: 10.w),

                                Text(
                                  item == null
                                      ? "01"
                                      : item.quantity.toString().padLeft(
                                          2,
                                          "0",
                                        ),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                _qtyButton(
                                  icon: Icons.remove,
                                  onTap: item == null
                                      ? null
                                      : () {
                                          if (item.quantity > 1) {
                                            context
                                                .read<CartCubit>()
                                                .updateCart(
                                                  item.id,
                                                  item.quantity - 1,
                                                );
                                          }
                                        },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: isLoading ? 3 : items.length),
          ),
        );
      },
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade300,
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
