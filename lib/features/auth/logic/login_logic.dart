import 'package:flutter/material.dart';

import '../../../core/app_routes/app_routes_name.dart';

Future<void> logIn({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
}) async {
  if (formKey.currentState!.validate()) {
    Navigator.pushNamed(context, AppRoutes.home);
  }
}
