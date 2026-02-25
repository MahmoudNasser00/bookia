import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final dynamic color;
  final dynamic textColor;
  final dynamic width;
  final dynamic height;
  final Widget? leading;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.color,
    required this.textColor,
    required this.width,
    required this.height,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20.r),
        ),
        fixedSize: Size(width, height),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[leading!, SizedBox(width: 8.w)],
          Text(
            text,
            style: AppTextStyles.playfairDisplayLarge(
              context,
              color: textColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
