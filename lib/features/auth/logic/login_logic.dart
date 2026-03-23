import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_routes/app_routes_name.dart';
import '../../../core/storage/token_storage.dart';
import '../cubit/auth_cubit.dart';

Future<void> logIn({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String email,
  required String password,
}) async {
  if (!formKey.currentState!.validate()) return;

  final authCubit = context.read<AuthCubit>();

  final user = await authCubit.login(email, password);

  if (authCubit.state == "success" && user != null) {
    final token = user.token;
    await TokenStorage.saveToken(token);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  } else if (authCubit.state == "error") {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Failed")));
  }
}
