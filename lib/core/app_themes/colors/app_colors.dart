import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color primary_button_color = Color(0xFFBFA054);
  static const Color blue = Color(0xFF007AFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  /// Text Form Colors
  static const Color labelTextColor = black;
  static const Color hintColor = Color(0xFF8D9499);
  static const Color text_field_color = Color(0xffe8ecf4);

  /// Error
  static const Color error = Colors.red;
}
