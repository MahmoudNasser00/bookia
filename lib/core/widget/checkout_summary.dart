import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/checkout/models/checkout_model.dart';
import '../app_themes/app_text_styles.dart';
import '../app_themes/colors/app_colors.dart';

class CheckoutSummary extends StatelessWidget {
  final CheckoutModel checkout;

  const CheckoutSummary({super.key, required this.checkout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...checkout.items.map(
          (item) => ListTile(
            title: Text(
              item.name,
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: AppColors.black,
              ),
            ),
            subtitle: Text(
              "Qty: ${item.quantity}",
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: AppColors.black,
              ),
            ),
            trailing: Text(
              "\$${item.total}",
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: AppColors.black,
              ),
            ),
          ),
        ),

        const Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.total.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                color: AppColors.black,
              ),
            ),
            Text(
              "\$${checkout.total}",
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
