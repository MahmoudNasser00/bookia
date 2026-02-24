import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/generated/assets.dart';

class PasswordChangePage extends StatelessWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.iconsSuccessfully,
              width: 100.w,
              height: 100.w,
            ),
            SizedBox(height: 35.h),
            Text(
              LocaleKeys.password_changed.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontSize: 30.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              LocaleKeys.Your_password_has_been_changed_successfully.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              text: LocaleKeys.back_to_login.tr(),
              color: AppColors.primary_button_color,
              textColor: AppColors.white,
              width: 331.w,
              height: 56.h,
            ),
          ],
        ),
      ),
    );
  }
}
