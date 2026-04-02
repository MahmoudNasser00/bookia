import 'package:bookia/core/helpers/validations/app_form_validations.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_routes/app_routes_name.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/widget/custom_button.dart';
import '../../cubit/password_changed_cubit.dart';
import '../../cubit/password_changed_state.dart';

class PasswordChanged extends StatefulWidget {
  const PasswordChanged({Key? key}) : super(key: key);

  @override
  _PasswordChangedState createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordChangedCubit, PasswordChangedState>(
      listener: (context, state) {
        if (state is PasswordChangedSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        }

        if (state is PasswordChangedError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(
              title: LocaleKeys.new_password.tr(),
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .center,
                      mainAxisSize: .max,
                      children: [
                        // current password
                        CustomTextfield(
                          hintText: LocaleKeys.current_password.tr(),
                          controller: currentPasswordController,
                          isPassword: true,
                          inputFormatters: AppFormValidations.phoneFormatter,
                          validator: AppFormValidations.passwordValidator,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        // new password
                        CustomTextfield(
                          hintText: LocaleKeys.new_password.tr(),
                          controller: newPasswordController,
                          isPassword: true,
                          inputFormatters: AppFormValidations.phoneFormatter,
                          validator: AppFormValidations.passwordValidator,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        // confirm password
                        CustomTextfield(
                          hintText: LocaleKeys.confirm_password.tr(),
                          controller: confirmPasswordController,
                          isPassword: true,
                          inputFormatters: AppFormValidations.phoneFormatter,
                          validator: AppFormValidations.passwordValidator,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 22.h, left: 26.w, right: 26.w),
          child: BlocBuilder<PasswordChangedCubit, PasswordChangedState>(
            builder: (context, state) {
              return CustomButton(
                text: state is PasswordChangedLoading
                    ? "Updating..."
                    : LocaleKeys.update_password.tr(),
                color: AppColors.primary_button_color,
                textColor: AppColors.white,
                width: 331.w,
                height: 56.h,
                onPressed: state is PasswordChangedLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<PasswordChangedCubit>().updatePassword(
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                            confirmPassword: confirmPasswordController.text,
                          );
                        }
                      },
              );
            },
          ),
        ),
      ),
    );
  }
}
