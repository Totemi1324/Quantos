import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';

enum CodingMode {
  simulator,
  annealer,
}

class CodingModesStoreService
    extends StoreService<List<DropdownMenuItem<CodingMode>>> {
  static final List<DropdownMenuItem<CodingMode>> _default = [
    const DropdownMenuItem(
      value: CodingMode.simulator,
      child: Text("Simulator"),
    ),
    const DropdownMenuItem(
      value: CodingMode.annealer,
      child: Text("DWave Advantage"),
    ),
  ];

  CodingModesStoreService(Locale currentLocale)
      : super(_default, currentLocale);

  @override
  List<DropdownMenuItem<CodingMode>> getLocalizedStore(
      AppLocalizations localization) {
    final List<DropdownMenuItem<CodingMode>> localizedStore = [
      DropdownMenuItem(
        value: CodingMode.simulator,
        child: Text(localization.codingModeSimulator),
      ),
      DropdownMenuItem(
        value: CodingMode.annealer,
        child: Text(localization.codingModeAnnealer),
      ),
    ];

    return localizedStore;
  }
}
