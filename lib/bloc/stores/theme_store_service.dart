import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';

class ThemeStoreService
    extends StoreService<List<DropdownMenuItem<Brightness>>> {
  static final List<DropdownMenuItem<Brightness>> _default = [
    const DropdownMenuItem(
      value: Brightness.dark,
      child: Text("Dark"),
    ),
    const DropdownMenuItem(
      value: Brightness.light,
      child: Text("Light"),
    ),
  ];

  ThemeStoreService(Locale currentLocale) : super(_default, currentLocale);

  @override
  List<DropdownMenuItem<Brightness>> getLocalizedStore(
      AppLocalizations localization) {
    final List<DropdownMenuItem<Brightness>> localizedStore = [
      DropdownMenuItem(
        value: Brightness.dark,
        child: Text(localization.themeDark),
      ),
      DropdownMenuItem(
        value: Brightness.light,
        child: Text(localization.themeLight),
      ),
    ];

    return localizedStore;
  }
}
