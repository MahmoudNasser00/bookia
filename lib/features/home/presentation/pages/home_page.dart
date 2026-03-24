import 'package:bookia/core/generated/assets.dart';
import 'package:bookia/core/widget/custom_bottom_nav_item.dart';
import 'package:bookia/features/home/presentation/pages/items/home_tab.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_themes/colors/app_colors.dart';
import '../../../../core/network/api_client.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../data/home_data_source.dart';
import '../../logic/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeDataSource(ApiClient()))..loadHome(),
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [HomeTab(), WishlistTab(), CartTab(), ProfileTab()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (index) {
              _tabController.animateTo(index);
            },
            items: [
              _buildNavItem(
                iconPath: Assets.iconsHome,
                index: 0,
                label: "Home",
              ),
              _buildNavItem(
                iconPath: Assets.iconsWishlist,
                index: 1,
                label: "Wishlist",
              ),
              _buildNavItem(
                iconPath: Assets.iconsCart,
                index: 2,
                label: "Cart",
              ),
              _buildNavItem(
                iconPath: Assets.iconsProfile,
                index: 3,
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: CustomBottomNavItem(
        iconPath: iconPath,
        label: label,
        isSelected: currentIndex == index,
        selectedColor: AppColors.primary_button_color,
        unselectedColor: Colors.grey,
        width: 25,
        height: 23,
      ),
      label: label,
    );
  }
}
