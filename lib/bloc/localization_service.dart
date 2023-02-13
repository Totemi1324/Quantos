import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationService extends Cubit<Locale> {
  static final List<Locale> _supportedLocales = [
    const Locale("en"),
    const Locale("de"),
  ];

  static final List<LocalizationsDelegate<Object>> _localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  LocalizationService() : super(const Locale('en')) {
    setLocale(Locale(Platform.localeName.substring(0, 2)));
  }

  List<Locale> get supportedLocales => _supportedLocales;

  List<LocalizationsDelegate<Object>> get localizationsDelegates =>
      _localizationsDelegates;

  int get currentLocaleIndex {
    var index = supportedLocales.indexOf(state);
    return index >= 0 ? index : 0;
  }

  void setLocale(Locale newLocale) {
    if (!AppLocalizations.delegate.isSupported(newLocale)) return;

    emit(newLocale);
  }
}
