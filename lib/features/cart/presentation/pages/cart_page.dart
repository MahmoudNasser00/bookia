import 'package:bookia/core/app_themes/colors/app_colors.dart';
import 'package:bookia/core/widget/custom_appbar.dart';
import 'package:bookia/core/widget/custom_button.dart';
import 'package:bookia/features/cart/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/cubit/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_themes/app_text_styles.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../../../../core/widget/cart_grid_widget.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(
          title: LocaleKeys.my_cart.tr(),
          centerTitle: true,
          showBackButton: false,
        ),

        const CartGridWidget(),
      ],
    );
  }
}
