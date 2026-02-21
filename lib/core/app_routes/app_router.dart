import 'package:flutter/material.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic>? push(String route, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  static Future<dynamic>? pushReplacement(String route, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }
}
