import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leadingWidth: 80.w,
        leading: Padding(
          padding: EdgeInsets.only(top: 24.w, left: 24.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 41.h,
              width: 41.w,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 236, 244),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 19.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 29.h),

        child: Column(
          children: <Widget>[
            Text(
              LocaleKeys.welcome_back.tr(),
              style: GoogleFonts.playfairDisplay(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 32.h),
            CustomTextfield(
              hintText: LocaleKeys.email.tr(),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15.h),
            CustomTextfield(
              hintText: LocaleKeys.password.tr(),
              controller: passwordController,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 13.h),
            Row(
              crossAxisAlignment: .center,
              mainAxisAlignment: .end,
              mainAxisSize: .max,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: Text(
                    LocaleKeys.forgot_password.tr(),
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: LocaleKeys.login,
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              color: AppColors.primary_button_color,
              textColor: AppColors.white,
              width: 331.w,
              height: 56.h,
            ),
            SizedBox(height: 44.h),
            Row(
              children: [
                const Expanded(
                  child: Divider(thickness: 1, color: AppColors.hintColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    LocaleKeys.or.tr(),
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 1, color: AppColors.hintColor),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: LocaleKeys.sign_in_with_google,
              onPressed: () {},
              color: AppColors.white,
              textColor: AppColors.black,
              width: 329.w,
              height: 56.h,
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: LocaleKeys.sign_in_with_apple,
              onPressed: () {},
              color: AppColors.white,
              textColor: AppColors.black,
              width: 329.w,
              height: 56.h,
            ),
            Center(
              child: Row(
                spacing: 2.w,
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                mainAxisSize: .max,
                children: [
                  Text(
                    LocaleKeys.dont_have_account,
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      LocaleKeys.register,
                      style: GoogleFonts.playfairDisplay(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,

                        color: AppColors.primary_button_color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
