import 'package:bookia/core/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/home/data/models/product_model.dart';
import '../app_routes/app_routes_name.dart';
import '../app_themes/app_text_styles.dart';
import '../app_themes/colors/app_colors.dart';

class BestSellerGridWidget extends StatelessWidget {
  final List<ProductModel> books;
  final bool isLoading;

  const BestSellerGridWidget({
    super.key,
    required this.books,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final items = books.isEmpty ? List.generate(6, (_) => null) : books;

    return Skeletonizer(
      ignoreContainers: true,
      enabled: isLoading,
      switchAnimationConfig: SwitchAnimationConfig(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 11.w,
          mainAxisSpacing: 30,
          childAspectRatio: .5,
        ),
        itemBuilder: (context, index) {
          final book = items[index];

          return Column(
            mainAxisSize: .min,
            spacing: 6.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // book image
              Expanded(
                child: InkWell(
                  onTap: book == null
                      ? null
                      : () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetails,
                            arguments: book,
                          );
                        },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                    ),
                    child: book == null
                        ? const SizedBox()
                        : Image.network(book.image, fit: BoxFit.fill),
                  ),
                ),
              ),
              // book name
              Text(
                book?.name ?? "Book Name",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.playfairDisplayLarge(
                  context,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: AppColors.black,
                ),
              ),

              Row(
                crossAxisAlignment: .center,
                mainAxisAlignment: .spaceBetween,
                mainAxisSize: .max,
                children: [
                  // book price
                  Text(
                    book?.price.toString() ?? "0",
                    style: AppTextStyles.playfairDisplayLarge(
                      context,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                      color: AppColors.black,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20.r),
                      ),
                      fixedSize: Size(72.w, 27.h),
                    ),

                    onPressed: () {
                      context.read<CartCubit>().addToCart(book!.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to cart")),
                      );
                    },
                    child: Text(
                      LocaleKeys.buy.tr(),
                      style: AppTextStyles.playfairDisplayLarge(
                        context,
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
