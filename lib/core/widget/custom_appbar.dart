import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_themes/colors/app_colors.dart';
import '../generated/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showAppIcon;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.showAppIcon = false,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: 80.w,
      centerTitle: centerTitle,
      leading: showBackButton
          ? Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: showAppIcon
                  ? SvgPicture.asset(
                      Assets.iconsLogo,
                      width: 99.w,
                      height: 30.w,
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        width: 41.w,
                        height: 41.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.backButtonColor,
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 15.sp),
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
            )
          : null,
      title: title != null
          ? Text(title!, style: Theme.of(context).textTheme.titleLarge)
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
