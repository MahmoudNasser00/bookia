import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final dynamic color;
  final dynamic textColor;
  final dynamic width;
  final dynamic height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.width,
    required this.height,
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
      child: Text(
        text,
        style: GoogleFonts.playfairDisplay(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: textColor,
        ),
      ),
    );
  }
}
