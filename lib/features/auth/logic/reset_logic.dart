import 'package:flutter/material.dart';

import '../../../core/app_routes/app_routes_name.dart';

Future<void> resetPassword({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
}) async {
  if (formKey.currentState!.validate()) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.passwordChange,
      (route) => false,
    );
  }
}
