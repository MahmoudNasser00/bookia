import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class AppConstants {
  /// App Border Radius
  static const double borderRadius = 24;
  static BorderRadius borderRadiusCircular = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius borderRadiusCircularButton = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius textFormBorderRadius = BorderRadius.circular(
    borderRadius,
  );

  /// App Horizontal Padding
  static const double horizontalPadding = 16;
  static const horizontalPaddingEdge = EdgeInsets.symmetric(
    horizontal: horizontalPadding,
  );

  static const double bottomNavBarHeight = 80;
}
