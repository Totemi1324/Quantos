import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';

class AgeClassesStoreService extends StoreService<Map<int, String>> {
  static final Map<int, String> _default = {
    0: "15-18",
    1: "19-28",
    2: "29-59",
    3: "60+",
  };

  AgeClassesStoreService(Locale currentLocale) : super(_default, currentLocale);

  @override
  Map<int, String> getLocalizedStore(AppLocalizations localization) {
    final Map<int, String> localizedStore = {
      0: localization.profileAgeScreenSliderClass1,
      1: localization.profileAgeScreenSliderClass2,
      2: localization.profileAgeScreenSliderClass3,
      3: localization.profileAgeScreenSliderClass4,
    };

    return localizedStore;
  }
}
