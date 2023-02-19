import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';
import '../../';

class DifficultyStoreService extends StoreService<Map<Difficulty, String>> {
  static final Map<Difficulty, String> _default = {
    Difficulty.easy: "Easy",
    Difficulty.advanced: "Advanced",
    Difficulty.challenging: "Challenging",
  };

  DifficultyStoreService(Locale currentLocale) : super(_default, currentLocale);
  
  @override
  Map<int, String> getLocalizedStore(AppLocalizations localization) {
    final Map<Difficulty, String> localizedStore = {
      Difficulty.easy: localization.lectionScreenDifficultyClass1,
      Difficulty.advanced: localization.lectionScreenDifficultyClass2,
      Difficulty.challenging: localization.lectionScreenDifficultyClass3,
    };

    return localizedStore;
  }
}
