import 'package:bookia/features/auth/logic/verify_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_routes/app_routes_name.dart';
import '../cubit/auth_cubit.dart';

Future<void> forgotPassword({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String email,
}) async {
  if (formKey.currentState!.validate()) {
    final authCubit = context.read<AuthCubit>();
    final user = await authCubit.forgetPassword(email);
    if (authCubit.state == "success") {
      Navigator.pushNamed(
        context,
        AppRoutes.verifyCode,
        arguments: {"source": VerifySource.forgotPassword, "email": email},
      );
    } else if (authCubit.state == "error") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("try again later")));
    }
  }
}
