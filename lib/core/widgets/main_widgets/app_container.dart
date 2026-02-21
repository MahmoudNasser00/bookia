import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
    this.constraints,
    this.onTap,
    this.padding,
    this.margin,
    this.disable = false,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
  });

  final Widget child;
  final BoxConstraints? constraints;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool disable;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disable ? .5 : 1,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          color: AppColors.secondary,
          borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
          child: AppInkWell(
            borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
            onTap: onTap,
            child: Container(
              width: width,
              height: height,
              padding:
                  padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              constraints: constraints,
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
                border: border,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
