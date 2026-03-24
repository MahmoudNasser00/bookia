import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/features/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/cart_grid_widget.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  double calculateTotal(List items) {
    double total = 0;

    for (var item in items) {
      total += item.price * item.quantity;
    }

    return total;
  }

  @override
  void initState() {
    super.initState();

    context.read<CartCubit>().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: "My Cart",
          centerTitle: true,
          showBackButton: false,
        ),

        const CartGridWidget(),

        /// Total + Checkout
        SliverFillRemaining(
          hasScrollBody: false,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final items = state is CartLoaded ? state.items : [];

              final total = calculateTotal(items);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total:", style: TextStyle(fontSize: 16)),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// Checkout
                    CustomButton(
                      text: "Checkout",
                      color: AppColors.primary_button_color,
                      textColor: AppColors.white,
                      width: double.infinity,
                      height: 55.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
