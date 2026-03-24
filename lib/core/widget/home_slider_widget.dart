import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeSliderWidget extends StatefulWidget {
  final List sliders;
  final bool isLoading;

  const HomeSliderWidget({
    super.key,
    required this.sliders,
    required this.isLoading,
  });

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sliders = widget.sliders.isEmpty
        ? List.generate(5, (_) => null)
        : widget.sliders;

    return Skeletonizer(
      enabled: widget.isLoading,
      ignoreContainers: true,
      switchAnimationConfig: SwitchAnimationConfig(),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: .9,
              aspectRatio: 2,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index);
              },
            ),
            items: sliders.map((slider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: slider == null
                      ? const SizedBox()
                      : Image.network(slider.image, fit: BoxFit.fill),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliders.asMap().entries.map((entry) {
              return Container(
                width: currentIndex == entry.key ? 18 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: currentIndex == entry.key
                      ? Colors.orange
                      : Colors.grey.shade300,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
