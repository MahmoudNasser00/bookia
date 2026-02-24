import 'package:bookia/features/auth/logic/verify_source.dart';
import 'package:flutter/material.dart';

import '../../../core/app_routes/app_routes_name.dart';

Future<void> registar({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
}) async {
  if (formKey.currentState!.validate()) {
    Navigator.pushNamed(
      context,
      AppRoutes.verifyCode,
      arguments: VerifySource.register,
    );
  }
}
