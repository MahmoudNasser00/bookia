import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class AppConstants {
  AppConstants._();

  /// Border Radius

  static double get borderRadius => 24.r;

  static BorderRadius get borderRadiusCircular =>
      BorderRadius.circular(borderRadius);

  static BorderRadius get borderRadiusCircularButton =>
      BorderRadius.circular(borderRadius);

  static BorderRadius get textFormBorderRadius =>
      BorderRadius.circular(borderRadius);

  /// Padding

  static double get horizontalPadding => 16.w;

  static EdgeInsets get horizontalPaddingEdge =>
      EdgeInsets.symmetric(horizontal: horizontalPadding);

  /// Bottom Navigation

  static double get bottomNavBarHeight => 80.h;
}
