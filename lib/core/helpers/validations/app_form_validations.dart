import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

import '../../localization/generated/locale_keys.g.dart';

sealed class AppFormValidations {
  AppFormValidations._(); // prevent instantiation

  /* ===========================
        USERNAME
  ============================ */

  static final List<TextInputFormatter> userNameFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FFa-zA-Z0-9_.-]')),
  ];

  static final RegExp _userNameRegex = RegExp(
    r'^[\u0600-\u06FFa-zA-Z0-9_.-]{3,16}$',
  );

  static String? userNameValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.usernameIsRequired.tr();
    }

    if (!_userNameRegex.hasMatch(input)) {
      return LocaleKeys.userNameMustBe316Character.tr();
    }

    return null;
  }

  /* ===========================
        EMAIL
  ============================ */

  static final List<TextInputFormatter> emailFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-]')),
  ];

  static final RegExp _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');

  static String? emailValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.emailIsRequired.tr();
    }

    if (!_emailRegex.hasMatch(input)) {
      return LocaleKeys.enterValidEmail.tr();
    }

    return null;
  }

  static String? emailOrPhoneValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.emailIsRequired.tr();
    }

    if (!_emailRegex.hasMatch(input) && !_egyptPhoneRegex.hasMatch(input)) {
      return LocaleKeys.enterValidEmailOrPhoneNumber.tr();
    }

    return null;
  }

  /* ===========================
        PHONE
  ============================ */

  // Egyptian phone number example
  static final RegExp _egyptPhoneRegex = RegExp(r'^01[0-9]{9}$');

  static final List<TextInputFormatter> phoneFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
  ];

  static String? phoneValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.phoneNumberIsRequired.tr();
    }

    if (!_egyptPhoneRegex.hasMatch(input)) {
      return LocaleKeys.enterValidPhoneNumber.tr();
    }

    return null;
  }

  /* ===========================
        OTP
  ============================ */

  static final List<TextInputFormatter> otpFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(6),
  ];

  static String? otpValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.codeIsRequired.tr();
    }

    if (input.length != 6) {
      return LocaleKeys.enterValidCode.tr();
    }

    return null;
  }

  /* ===========================
        PASSWORD
  ============================ */

  static final List<TextInputFormatter> passwordFormatter = [
    FilteringTextInputFormatter.allow(
      RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?~` ]'),
    ),
  ];

  static String? passwordValidator(String? value) {
    final input = value?.trim();

    if (input == null || input.isEmpty) {
      return LocaleKeys.passwordIsRequired.tr();
    }

    if (input.length < 8) {
      return LocaleKeys.passwordMustBeAtLeast8Characters.tr();
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(input)) {
      return LocaleKeys.passwordMustContainLetters.tr();
    }

    if (!RegExp(r'\d').hasMatch(input)) {
      return LocaleKeys.passwordMustContainNumbers.tr();
    }

    return null;
  }

  static String? confirmPasswordValidator(
    String? confirmPassword,
    String? password,
  ) {
    final confirm = confirmPassword?.trim();
    final pass = password?.trim();

    if (confirm == null || confirm.isEmpty) {
      return LocaleKeys.passwordIsRequired.tr();
    }

    if (confirm != pass) {
      return LocaleKeys.passwordsDoNotMatch.tr();
    }

    return null;
  }
}
