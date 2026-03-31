import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/features/profile/models/my_order_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../cubit/my_order_cubit.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrderCubit>().fetchMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            onBackPressed: () => Navigator.pop(context),
            title: LocaleKeys.my_orders.tr(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocBuilder<MyOrderCubit, MyOrderModel?>(
                builder: (context, myOrder) {
                  final isLoading = myOrder == null;

                  /// Loading
                  if (isLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  /// Empty State
                  if (myOrder.orders.isEmpty) {
                    return SizedBox(
                      height: 400.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 60.sp,
                              color: AppColors.hintColor,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              LocaleKeys.No_Orders_Yet.tr(),
                              style: AppTextStyles.playfairDisplayLarge(
                                context,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  /// Data
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myOrder.orders.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final order = myOrder.orders[index];

                      return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${LocaleKeys.order_number.tr()} ${order.orderCode}",
                                  style: AppTextStyles.playfairDisplayLarge(
                                    context,
                                    color: AppColors.black,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  order.orderDate,
                                  style: AppTextStyles.playfairDisplayLarge(
                                    context,
                                    color: AppColors.hintColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Divider(
                              color: AppColors.hintColor,
                              thickness: 1.h,
                              indent: 25.w,
                              endIndent: 15.w,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "${LocaleKeys.total.tr()}: \$${order.total}",
                              style: AppTextStyles.playfairDisplayLarge(
                                context,
                                color: AppColors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
