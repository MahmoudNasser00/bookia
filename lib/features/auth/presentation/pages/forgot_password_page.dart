import 'package:bookia/core/helpers/validations/app_form_validations.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:bookia/features/auth/logic/fogot_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
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
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Text(
                LocaleKeys.forgot_password.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontSize: 30.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                LocaleKeys
                    .Don_t_worry_It_occurs_Please_enter_the_email_address_linked_with_your_account.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30.h),
              CustomTextfield(
                hintText: LocaleKeys.email.tr(),
                validator: AppFormValidations.emailValidator,
                inputFormatters: AppFormValidations.emailFormatter,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 38.h),
              CustomButton(
                onPressed: () {
                  forgotPassword(context: context, formKey: _formKey);
                },
                text: LocaleKeys.send_code.tr(),
                color: AppColors.primary_button_color,
                textColor: AppColors.white,
                width: 331.w,
                height: 56.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
