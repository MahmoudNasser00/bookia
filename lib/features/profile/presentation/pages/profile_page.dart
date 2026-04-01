import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/app_routes/app_routes_name.dart';
import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/storage/token_storage.dart';
import '../../cubit/profile_cubit.dart';
import '../../models/profile_model.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

bool _isLoggingOut = false;

class _ProfileTabState extends State<ProfileTab> {
  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      await TokenStorage.clearToken();

      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.WelcomeScreen);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to logout')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: LocaleKeys.profile_title.tr(),
          centerTitle: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: _isLoggingOut ? null : _handleLogout,
              icon: SvgPicture.asset(
                Assets.iconsExit,
                width: 16.w,
                height: 16.h,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<ProfileCubit, ProfileModel?>(
              builder: (context, profile) {
                final isLoading = profile == null;

                return Skeletonizer(
                  enabled: isLoading,
                  ignoreContainers: true,
                  switchAnimationConfig: SwitchAnimationConfig(),
                  child: Column(
                    children: [
                      /// profile header
                      Row(
                        crossAxisAlignment: .center,
                        mainAxisSize: .max,
                        spacing: 20.w,
                        children: [
                          CircleAvatar(
                            radius: 50.w,
                            backgroundImage: isLoading
                                ? null
                                : NetworkImage(profile.image),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  profile?.name ?? "User Name",
                                  style: AppTextStyles.playfairDisplayLarge(
                                    context,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.sp,
                                    color: AppColors.black,
                                  ),
                                  softWrap: true,
                                ),

                                Text(
                                  profile?.email ?? "email@email.com",
                                  style: AppTextStyles.playfairDisplayLarge(
                                    context,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: AppColors.hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 35.h),
                      // my order
                      CustomButton(
                        text: LocaleKeys.my_orders.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.myOrder);
                        },
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // edit profile
                      CustomButton(
                        text: LocaleKeys.edit_profile.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.editProfile);
                        },
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),
                      // reset password
                      CustomButton(
                        text: LocaleKeys.reset_password.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {},
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),
                      // faq
                      CustomButton(
                        text: LocaleKeys.FAQ.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {},
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // contact us
                      CustomButton(
                        text: LocaleKeys.contact_us.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {},
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // privacy & terms
                      CustomButton(
                        text: LocaleKeys.privacy_terms.tr(),
                        color: AppColors.white,
                        textColor: AppColors.black,
                        width: double.infinity,
                        height: 54.h,
                        onPressed: () {},
                        postFiex: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
