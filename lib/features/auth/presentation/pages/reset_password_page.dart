import 'package:bookia/features/auth/logic/reset_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/helpers/validations/app_form_validations.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_textfield.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: <Widget>[
              Text(
                LocaleKeys.create_new_password.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 30.sp,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                LocaleKeys
                    .Your_new_password_must_be_unique_from_those_previously_used.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ), // password
              SizedBox(height: 32.h),
              CustomTextfield(
                hintText: LocaleKeys.password.tr(),
                isPassword: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: AppFormValidations.passwordValidator,
                inputFormatters: AppFormValidations.passwordFormatter,
              ),
              SizedBox(height: 15.h),
              // confirm password
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
              SizedBox(height: 13.h),
              // login button
              CustomButton(
                text: LocaleKeys.login.tr(),
                onPressed: () {
                  resetPassword(context: context, formKey: _formKey);
                },
                color: AppColors.primary_button_color,
                textColor: AppColors.white,
                width: 331.w,
                height: 56.h,
              ),
              SizedBox(height: 44.h),
            ],
          ),
        ),
      ),
    );
  }
}
