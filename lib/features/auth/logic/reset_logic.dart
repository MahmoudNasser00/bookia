import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_routes/app_routes_name.dart';
import '../cubit/auth_cubit.dart';

Future<void> resetPassword({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String verify_code,
  required String password,
  required String confirmPassword,
}) async {
  if (formKey.currentState!.validate()) {
    final authCubit = context.read<AuthCubit>();
    final user = await authCubit.resetPassword(
      verify_code,
      password,
      confirmPassword,
    );
    if (authCubit.state == "success" && user != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.passwordChange,
        (route) => false,
      );
    } else if (authCubit.state == "error") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("try again later")));
    }
  }
}
