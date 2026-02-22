import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_routes/app_routes_name.dart';
import '../../../../core/generated/assets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 50000.h,
            width: 50000.w,
            child: Image.asset(Assets.imagesBackground, fit: BoxFit.cover),
          ),
          Center(
            child: Padding(
              padding: EdgeInsetsGeometry.only(bottom: 94.h, top: 135.h),
              child: Column(
                spacing: 28.h,
                crossAxisAlignment: .center,
                mainAxisSize: .max,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.iconsLogo,
                    width: 210.w,
                    height: 66.h,
                  ),
                  Text(
                    LocaleKeys.order_now.tr(),
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 300.h),
                    child: Column(
                      spacing: 15.h,
                      children: [
                        CustomButton(
                          text: LocaleKeys.login.tr(),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                          color: AppColors.primary_button_color,
                          textColor: AppColors.white,
                          width: 331.w,
                          height: 56.h,
                        ),
                        CustomButton(
                          text: LocaleKeys.register.tr(),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          color: AppColors.white,
                          textColor: AppColors.black,
                          width: 331.w,
                          height: 56.h,
                        ),
                      ],
                    ),
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
