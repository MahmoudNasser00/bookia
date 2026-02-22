
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'locale_state.dart';
import 'locale_repository.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LocaleRepository repository;

  LocaleCubit(this.repository)
      : super(const LocaleState(Locale('en')));

  Future<void> loadSavedLocale() async {
    final locale = await repository.getSavedLocale();
    emit(LocaleState(locale));
  }

  Future<void> changeLocale(Locale locale) async {
    await repository.saveLocale(locale);
    emit(LocaleState(locale));
  }
}
