import 'package:bookia/core/app_themes/app_text_styles.dart';
import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int maxLines;
  final dynamic inputFormatters;

  const CustomTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: _obscure,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      style: AppTextStyles.playfairDisplayLarge(
        context,
        color: AppColors.hintColor,
        fontSize: 15.sp,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.hintColor),
        filled: true,

        fillColor: const Color(0xFFE8ECF4),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        errorStyle: TextStyle(fontSize: 12.sp, color: AppColors.error),
      ),
    );
  }
}
