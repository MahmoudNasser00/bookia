import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: "Profile",
          centerTitle: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.iconsExit,
                width: 16.w,
                height: 16.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
