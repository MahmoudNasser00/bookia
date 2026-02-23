import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle playfairDisplayLarge(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
  }) {
    return GoogleFonts.playfairDisplay(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: fontSize?.sp ?? 30.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle ?? FontStyle.italic,
      color: color,
    );
  }
}
