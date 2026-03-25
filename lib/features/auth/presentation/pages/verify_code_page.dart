import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/helpers/validations/app_form_validations.dart';
import '../../../../core/widget/custom_button.dart';
import '../../cubit/auth_cubit.dart';
import '../../logic/verify_source.dart';

class VerifyCodePage extends StatefulWidget {
  final VerifySource source;
  final String? email;

  const VerifyCodePage({super.key, required this.source, this.email});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  late final _formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isButtonEnabled = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      switch (widget.source) {
        case VerifySource.register:
          final authCubit = context.read<AuthCubit>();
          final verify = authCubit.verifyEmail(pinController.text);
          if (await verify) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email verified successfully")),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("try again later")));
          }
          break;

        case VerifySource.forgotPassword:
          final authCubit = context.read<AuthCubit>();
          await authCubit.checkForgetPassword(
            widget.email!,
            pinController.text,
          );
          if (authCubit.state == "success") {
            Navigator.pushNamed(
              context,
              AppRoutes.resetPassword,
              arguments: pinController.text,
            );
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 29.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      LocaleKeys.otp_verification.tr(),
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
                          .Enter_the_verification_code_we_just_sent_on_your_email_address.tr(),
                      style: AppTextStyles.playfairDisplayLarge(
                        context,
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: AppFormValidations.otpFormatter,
                      validator: AppFormValidations.otpValidator,
                      onChanged: (value) {
                        setState(() {
                          isButtonEnabled = value.length == 6;
                        });
                      },
                      onCompleted: (value) {
                        verifyOtp();
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      color: AppColors.primary_button_color,
                      textColor: AppColors.white,
                      text: LocaleKeys.verify.tr(),
                      onPressed: isButtonEnabled ? verifyOtp : null,
                      width: 331.w,
                      height: 56.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 22.h),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(
              LocaleKeys.didnt_receive_code.tr(),
              style: AppTextStyles.playfairDisplayLarge(
                context,
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton(
              onPressed: () async {
                final authCubit = context.read<AuthCubit>();

                final resend = await authCubit.resendVerifyCode();

                if (resend) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Code resent successfully")),
                  );
                }
              },
              child: Text(
                LocaleKeys.resend.tr(),
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontSize: 15.sp,
                  color: AppColors.primary_button_color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
