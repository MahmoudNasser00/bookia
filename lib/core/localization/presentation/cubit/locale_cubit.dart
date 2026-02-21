import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/get_saved_locale.dart';
import '../../domain/usecases/save_locale.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLocale getSavedLocale;
  final SaveLocale saveLocale;

  LocaleCubit({
    required this.getSavedLocale,
    required this.saveLocale,
  }) : super(const LocaleState(Locale('en'))) {
    _load();
  }

  Future<void> _load() async {
    final code = await getSavedLocale();
    if (code != null) {
      emit(LocaleState(Locale(code)));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    await saveLocale(locale.languageCode);
    emit(LocaleState(locale));
  }
}