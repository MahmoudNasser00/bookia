import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app_themes/colors/app_colors.dart';

/// MediaQuery

extension ResponsiveX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double get keyboardInset => MediaQuery.of(this).viewInsets.bottom;

  double get topSafeArea => MediaQuery.of(this).padding.top;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  /// Breakpoints
  bool get isMobile => screenWidth < 600;

  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  bool get isDesktop => screenWidth >= 1024;
}

/// ==========================
/// Localization
/// ==========================

extension AppLocalizationX on BuildContext {
  Locale get locale =>
      EasyLocalization.of(this)?.currentLocale ?? const Locale('en');

  bool get isArabic => locale.languageCode == 'ar';

  Future<void> changeLocale(Locale newLocale) async {
    await EasyLocalization.of(this)?.setLocale(newLocale);
  }
}

/// ==========================
/// Theme
/// ==========================

extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

/// ==========================
/// Snackbar
/// ==========================

extension SnackBarX on BuildContext {
  void showSnackBar(String text, {Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.maybeOf(this)?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor ?? AppColors.error,
        content: Text(
          text,
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

/// ==========================
/// Navigation
/// ==========================

extension NavigationX on BuildContext {
  Future<dynamic> push(
    String routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replace(
    String routeName, {
    Object? arguments,
    Object? result,
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  Future<dynamic> pushAndRemoveUntil(
    String routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }
}

/// ==========================
/// Date Picker
/// ==========================

extension DatePickerX on BuildContext {
  Future<DateTime?> showDatePickerDialog({DateTime? initialDate}) async {
    final today = DateTime.now();

    return showDatePicker(
      context: this,
      initialDate: initialDate ?? today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
  }
}
