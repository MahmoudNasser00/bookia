import 'dart:async';
import 'package:bookia/core/app_routes/app_routes_name.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/generated/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double _fontSizeFactor = 2;
  double _containerFactor = 1.5;
  double _textOpacity = 0;
  double _containerOpacity = 0;

  late AnimationController _controller;
  late Animation<double> _fontAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fontAnimation = Tween<double>(begin: 40.sp, end: 22.sp).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _fontSizeFactor = 1.06;
        _containerFactor = 2;
        _textOpacity = 1;
        _containerOpacity = 1;
      });
    });

    _navigate();
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.WelcomeScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = 1.sw;
    final height = 1.sh;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: height / _fontSizeFactor,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Text(
                      LocaleKeys.order_now.tr(),
                      style: AppTextStyles.playfairDisplayLarge(
                        context,
                        fontSize: 20.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                height: width / _containerFactor,
                width: width / _containerFactor,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Assets.iconsLogo,
                  width: 80.w,
                  height: 80.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
