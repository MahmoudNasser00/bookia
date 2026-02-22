import 'package:flutter/material.dart';
import '../helpers/storage/pref_helper.dart';

class LocaleRepository {
  static const _key = "language";

  Future<Locale> getSavedLocale() async {
    final code = await PrefHelper.get(_key);
    if (code != null) {
      return Locale(code);
    }
    return const Locale('en');
  }

  Future<void> saveLocale(Locale locale) async {
    await PrefHelper.save(_key, locale.languageCode);
  }
}
