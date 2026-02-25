import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          SvgPicture.asset(Assets.iconsSearch, width: 24.w, height: 24.w),
        ],
        showAppIcon: true,
      ),
    );
  }
}
