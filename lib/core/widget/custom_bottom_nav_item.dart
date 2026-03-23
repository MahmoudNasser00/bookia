import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const CustomBottomNavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    this.selectedColor = Colors.orange,
    this.unselectedColor = Colors.grey,
    this.width = 25,
    this.height = 23,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: width.w,
            height: height.h,
            colorFilter: ColorFilter.mode(
              isSelected ? selectedColor : unselectedColor,
              BlendMode.srcIn,
            ),
          ),
          if (isSelected) ...[
            SizedBox(height: 4.h),
            Container(
              width: 4.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
