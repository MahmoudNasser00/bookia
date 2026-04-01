import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_routes/app_routes_name.dart';
import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          spacing: 20.h,
          children: [
            SvgPicture.asset(
              Assets.iconsSuccessfully,
              height: 145.h,
              width: 145.w,
            ),
            Text(
              LocaleKeys
                  .Your_order_will_be_delivered_soon_Thank_you_for_choosing_our_app.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: AppColors.black,
              ),
              softWrap: true,
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: LocaleKeys.back_to_home.tr(),
              color: AppColors.primary_button_color,
              textColor: AppColors.white,
              width: 313.w,
              height: 56.h,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
