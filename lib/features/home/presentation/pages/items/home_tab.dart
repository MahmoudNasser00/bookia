import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app_routes/app_routes_name.dart';
import '../../../../../core/app_themes/app_text_styles.dart';
import '../../../../../core/app_themes/colors/app_colors.dart';
import '../../../../../core/generated/assets.dart';
import '../../../../../core/localization/generated/locale_keys.g.dart';
import '../../../../../core/widget/best_seller_grid_widget.dart';
import '../../../../../core/widget/custom_appbar.dart';
import '../../../../../core/widget/home_slider_widget.dart';
import '../../../data/models/product_model.dart';
import '../../../logic/home_cubit.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          showAppIcon: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              icon: SvgPicture.asset(
                Assets.iconsSearch,
                width: 24.w,
                height: 24.w,
              ),
            ),
          ],
        ),

        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final isLoading = state is HomeLoading;

            final sliders = state is HomeSuccess ? state.sliders : [];

            final bestSeller = state is HomeSuccess
                ? state.bestSeller
                : <ProductModel>[];

            return SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(19.w),
                  child: HomeSliderWidget(
                    sliders: sliders,
                    isLoading: isLoading,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Text(
                    LocaleKeys.best_seller.tr(),
                    style: AppTextStyles.playfairDisplayLarge(
                      context,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: BestSellerGridWidget(
                    books: bestSeller,
                    isLoading: isLoading,
                  ),
                ),
              ]),
            );
          },
        ),
      ],
    );
  }
}
