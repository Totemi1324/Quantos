import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './store_service.dart';

enum HelpCategory {
  accountIssue,
  bugReport,
  featureInquiry,
  other,
}

class RequestTypeStoreService
    extends StoreService<List<DropdownMenuItem<HelpCategory>>> {
  static final List<DropdownMenuItem<HelpCategory>> _default = [
    const DropdownMenuItem(
      value: HelpCategory.accountIssue,
      child: Text("I have a problem regarding my account"),
    ),
    const DropdownMenuItem(
      value: HelpCategory.bugReport,
      child: Text("I want to report a bug/error in the app"),
    ),
    const DropdownMenuItem(
      value: HelpCategory.featureInquiry,
      child: Text("I have an inquiry about the app or its contents"),
    ),
    const DropdownMenuItem(
      value: HelpCategory.other,
      child: Text("Other"),
    ),
  ];

  RequestTypeStoreService(Locale currentLocale)
      : super(_default, currentLocale);

  @override
  List<DropdownMenuItem<HelpCategory>> getLocalizedStore(
      AppLocalizations localization) {
    final List<DropdownMenuItem<HelpCategory>> localizedStore = [
      DropdownMenuItem(
        value: HelpCategory.accountIssue,
        child: Text(localization.helpRequestTypeAccont),
      ),
      DropdownMenuItem(
        value: HelpCategory.bugReport,
        child: Text(localization.helpRequestTypeBug),
      ),
      DropdownMenuItem(
        value: HelpCategory.featureInquiry,
        child: Text(
          localization.helpRequestTypeFeature,
        ),
      ),
      DropdownMenuItem(
        value: HelpCategory.other,
        child: Text(localization.helpRequestTypeOther),
      ),
    ];

    return localizedStore;
  }
}
