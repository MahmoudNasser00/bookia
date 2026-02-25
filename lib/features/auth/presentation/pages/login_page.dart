import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:bookia/features/auth/logic/login_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/helpers/validations/app_form_validations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/generated/assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 29.h),

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                LocaleKeys.welcome_back.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 30.sp,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 32.h),
              // email
              CustomTextfield(
                hintText: LocaleKeys.email.tr(),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppFormValidations.emailValidator,
                inputFormatters: AppFormValidations.emailFormatter,
              ),
              SizedBox(height: 15.h),
              // password
              CustomTextfield(
                hintText: LocaleKeys.password.tr(),
                controller: passwordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: AppFormValidations.passwordFormatter,
                validator: AppFormValidations.passwordValidator,
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
                      style: AppTextStyles.playfairDisplayLarge(
                        context,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              // login button
              CustomButton(
                text: LocaleKeys.login.tr(),
                onPressed: () {
                  logIn(context: context, formKey: _formKey);
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
                      style: AppTextStyles.playfairDisplayLarge(
                        context,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.black,
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
                text: LocaleKeys.sign_in_with_google.tr(),
                leading: SvgPicture.asset(Assets.iconsGoogle),
                onPressed: () {},
                color: AppColors.white,
                textColor: AppColors.black,
                width: 329.w,
                height: 56.h,
              ),
              SizedBox(height: 15.h),
              CustomButton(
                leading: SvgPicture.asset(
                  Assets.iconsApple,
                  width: 26.w,
                  height: 26.w,
                ),
                text: LocaleKeys.sign_in_with_apple.tr(),
                onPressed: () {},
                color: AppColors.white,
                textColor: AppColors.black,
                width: 329.w,
                height: 56.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 22.h),
        child: Row(
          spacing: 1.w,
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Text(
              LocaleKeys.dont_have_account.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
              child: Text(
                LocaleKeys.register.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.primary_button_color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
