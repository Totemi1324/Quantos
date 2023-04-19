import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './platform.dart';

enum DownloadSizeUnit {
  kilobyte,
  megabyte,
  gigabyte,
}

enum FileType {
  pdf,
  exe,
  json,
  ipynb,
}

class Download {
  final String id;
  final String categoryId;
  final String title;
  final DownloadSize size;
  final String description;
  final FileType type;
  final Map<String, String> links;
  final Set<Platform> availableOn;

  const Download(this.id,
      {required this.title,
      required this.description,
      required this.categoryId,
      required this.size,
      required this.type,
      required this.links,
      required this.availableOn});

  List<String> get locales =>
      links.keys.map((locale) => locale.toUpperCase()).toList();

  String? linkForLocale(String locale) => links.containsKey("")
      ? links[""]
      : (links.containsKey(locale) ? links[locale] : null);
}

class DownloadSize {
  final double size;
  final DownloadSizeUnit unit;

  const DownloadSize({required this.size, required this.unit});

  String convertToLocalizedString(BuildContext buildContext) {
    String localizedUnit;
    switch (unit) {
      case DownloadSizeUnit.kilobyte:
        localizedUnit =
            AppLocalizations.of(buildContext)!.downloadSizeUnitKilobyte;
        break;
      case DownloadSizeUnit.megabyte:
        localizedUnit =
            AppLocalizations.of(buildContext)!.downloadSizeUnitMegabyte;
        break;
      case DownloadSizeUnit.gigabyte:
        localizedUnit =
            AppLocalizations.of(buildContext)!.downloadSizeUnitGigabyte;
        break;
      default:
        localizedUnit = "NaN";
        break;
    }

    return "${size.toStringAsFixed(1)}$localizedUnit";
  }
}
