import 'package:bookia/core/app_routes/routes_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_strings.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case RoutesStrings.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => sl<HomeCubit>(),
              child: const HomeScreen(),
            );
          },
        );
      case RoutesStrings.controlsScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const ControlsScreen();
          },
        );
    }
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(child: Text(AppStrings.noRouteFound)),
        );
      },
    );
  }
}
