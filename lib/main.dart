import 'package:bookia/features/checkout/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (_) => WishlistCubit()..fetchWishlist()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => OrderCubit()),
          BlocProvider(create: (_) => ProfileCubit()..fetchProfile()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
