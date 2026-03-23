import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesListWidget extends StatelessWidget {
  final List categories;
  final bool isLoading;

  const CategoriesListWidget({
    super.key,
    required this.categories,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final items = categories.isEmpty
        ? List.generate(6, (_) => null)
        : categories;

    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: 80.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final cat = items[index];

            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: cat == null
                        ? null
                        : NetworkImage(cat.image),
                  ),
                  SizedBox(height: 6.h),
                  Text(cat?.name ?? "Category"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
