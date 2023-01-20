import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';

class ExperienceClassesStoreService extends StoreService<Map<int, String>> {
  static final Map<int, String> _default = {
    0: "Beginner",
    1: "Advanced",
    2: "Skilled",
  };

  ExperienceClassesStoreService(Locale currentLocale)
      : super(_default, currentLocale);

  @override
  Map<int, String> getLocalizedStore(AppLocalizations localization) {
    final Map<int, String> localizedStore = {
      0: localization.profileExperienceScreenSliderClass1,
      1: localization.profileExperienceScreenSliderClass2,
      2: localization.profileExperienceScreenSliderClass3,
    };

    return localizedStore;
  }
}
