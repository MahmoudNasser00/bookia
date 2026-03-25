import 'package:bookia/features/auth/logic/verify_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_routes/app_routes_name.dart';
import '../../../core/storage/token_storage.dart';
import '../cubit/auth_cubit.dart';

Future<void> register({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String name,
  required String email,
  required String password,
  required String passwordConfirmation,
}) async {
  if (formKey.currentState!.validate()) {
    final authCubit = context.read<AuthCubit>();

    final user = await authCubit.register(
      name,
      email,
      password,
      passwordConfirmation,
    );

    if (authCubit.state == "success" && user != null) {
      final token = user.token;
      await TokenStorage.saveToken(token);
      if (await authCubit.resendVerifyCode()) {
        Navigator.pushNamed(
          context,
          AppRoutes.verifyCode,
          arguments: {"source": VerifySource.register, "email": email},
        );
      }
    } else if (authCubit.state == "error") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("try again later or try another email")),
      );
    }
  }
}
