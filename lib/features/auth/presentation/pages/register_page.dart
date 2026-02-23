import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:bookia/features/auth/logic/registar_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_routes/app_routes_name.dart';
import '../../../../core/helpers/validations/app_form_validations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Column(
          children: [
            Text(
              LocaleKeys.register_title.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontSize: 30.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 32.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                spacing: 11.h,
                children: [
                  CustomTextfield(
                    hintText: LocaleKeys.username.tr(),
                    controller: userNameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: AppFormValidations.userNameFormatter,
                    validator: AppFormValidations.userNameValidator,
                  ),
                  CustomTextfield(
                    hintText: LocaleKeys.email.tr(),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: AppFormValidations.emailFormatter,
                    validator: AppFormValidations.emailValidator,
                  ),
                  CustomTextfield(
                    hintText: LocaleKeys.password.tr(),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: AppFormValidations.passwordFormatter,
                    validator: AppFormValidations.passwordValidator,
                    isPassword: true,
                  ),
                  CustomTextfield(
                    hintText: LocaleKeys.confirm_password.tr(),
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: AppFormValidations.passwordFormatter,
                    isPassword: true,
                    validator: (value) =>
                        AppFormValidations.confirmPasswordValidator(
                          value,
                          passwordController.text,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: LocaleKeys.register.tr(),
              onPressed: () {
                registar(context: context, formKey: _formKey);
              },
              color: AppColors.primary_button_color,
              textColor: AppColors.white,
              width: 331.w,
              height: 56.h,
            ),
            SizedBox(height: 134.h),

            Center(
              child: Row(
                spacing: 1.w,
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                mainAxisSize: .max,
                children: [
                  Text(
                    LocaleKeys.dont_have_account,
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
                      LocaleKeys.register,
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
          ],
        ),
      ),
    );
  }
}
