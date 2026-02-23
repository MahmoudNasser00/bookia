import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      leadingWidth: showBackButton ? 80.w : 0,
      leading: showBackButton
          ? Padding(
              padding: EdgeInsets.only(top: 24.w, left: 24.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: onBackPressed ?? () => Navigator.pop(context),
                child: Container(
                  height: 41.h,
                  width: 41.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 236, 244),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, size: 19.sp),
                ),
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
