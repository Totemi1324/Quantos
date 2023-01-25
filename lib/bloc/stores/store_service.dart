import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class StoreService<T> extends Cubit<T> {
  final T defaultStore;

  StoreService(this.defaultStore, Locale currentLocale) : super(defaultStore) {
    updateStore(currentLocale);
  }

  @protected
  AppLocalizations getAppLocalization(Locale locale) {
    return lookupAppLocalizations(locale);
  }

  @protected
  void updateStore(Locale locale) {
    final appLocalization = getAppLocalization(locale);

    final localizedStore = getLocalizedStore(appLocalization);

    emit(localizedStore);
  }

  T getLocalizedStore(AppLocalizations localization);
}
