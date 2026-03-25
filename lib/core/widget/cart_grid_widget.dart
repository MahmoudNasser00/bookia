import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/features/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/cubit/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'custom_button.dart';

class CartGridWidget extends StatefulWidget {
  const CartGridWidget({super.key});

  @override
  State<CartGridWidget> createState() => _CartGridWidgetState();
}

class _CartGridWidgetState extends State<CartGridWidget> {
  double calculateTotal(List items) =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isLoading = state is CartLoading || state is CartInitial;
        final items = state is CartLoaded ? state.items : [];
        final total = calculateTotal(items);

        if (!isLoading && items.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                LocaleKeys.No_items_in_cart.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
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
            delegate: SliverChildListDelegate([
              /// cart items
              ...List.generate(isLoading ? 3 : items.length, (index) {
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
                        /// image
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

                        /// info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// title + remove
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

                              /// quantity
                              Row(
                                children: [
                                  _qtyButton(
                                    icon: Icons.add,
                                    onTap: item == null
                                        ? null
                                        : () {
                                            context
                                                .read<CartCubit>()
                                                .updateCart(
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
              }),

              SizedBox(height: 10.h),

              /// total
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${LocaleKeys.total.tr()}:",
                        style: AppTextStyles.playfairDisplayLarge(
                          context,
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: AppTextStyles.playfairDisplayLarge(
                          context,
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// checkout
                  CustomButton(
                    text: LocaleKeys.checkout.tr(),
                    color: AppColors.primary_button_color,
                    textColor: AppColors.white,
                    width: double.infinity,
                    height: 55.h,
                    onPressed: () {
                      Navigator.pushNamed(context, '/checkout');
                    },
                  ),
                ],
              ),
            ]),
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
