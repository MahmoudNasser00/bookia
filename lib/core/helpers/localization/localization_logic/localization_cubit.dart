import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_methods.dart';
import '../../../utils/app_strings.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(BuildContext context) : super(const LocalizationChanged()) {
    _loadLanguage(context);
  }

  Future<void> _loadLanguage(BuildContext context) async {
    final languageCode =
        PrefHelper.get(PrefKeys.currentLanguage) ?? AppStrings.enLanguage;
    await AppMethods.changeLanguage(context, locale: Locale(languageCode));
  }
}
