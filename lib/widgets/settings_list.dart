import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/theme_service.dart';
import '../bloc/localization_service.dart';

import './section_separator.dart';
import './settings_item.dart';
import './ui/adaptive_switch.dart';
import './ui/adaptive_dropdown.dart';

class SettingsList extends StatelessWidget {
  final List<DropdownMenuItem> _languages = const [
    DropdownMenuItem(
      value: Locale('en'),
      child: Text("English"),
    ),
    DropdownMenuItem(
      value: Locale('de'),
      child: Text("Deutsch"),
    ),
  ];

  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> themes = [
      DropdownMenuItem(
        value: Brightness.dark,
        child: Text(AppLocalizations.of(context)!.themeDark),
      ),
      DropdownMenuItem(
        value: Brightness.light,
        child: Text(AppLocalizations.of(context)!.themeLight),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionSeparator(
          AppLocalizations.of(context)!.settingsSectionAccessibility,
        ),
        SettingsItem(
          title: AppLocalizations.of(context)!.settingsOptionAccessibilityMode,
          selector: AdaptiveSwitch(
            defaultEnabled:
                context.read<ThemeService>().accessibilityModeActive,
            onToggle: (newValue) =>
                context.read<ThemeService>().toggleAccessibilityMode(newValue),
          ),
        ),
        SettingsItem(
          title: AppLocalizations.of(context)!.settingsOptionColorblindTheme,
          selector: AdaptiveSwitch(
            defaultEnabled: context.read<ThemeService>().colorblindModeActive,
            onToggle: (newValue) =>
                context.read<ThemeService>().toggleColorblindMode(newValue),
          ),
        ),
        SectionSeparator(
          AppLocalizations.of(context)!.settingsSectionVisuals,
          topMargin: 30,
        ),
        SettingsItem(
          title: AppLocalizations.of(context)!.settingsOptionTheme,
          selector: AdaptiveDropdown(
            enabled: !context.watch<ThemeService>().accessibilityModeActive,
            items: themes,
            defaultSelectedIndex:
                Theme.of(context).brightness == Brightness.dark ? 0 : 1,
            onChanged: (newValue) =>
                context.read<ThemeService>().selectTheme(newValue),
          ),
        ),
        SectionSeparator(
          AppLocalizations.of(context)!.settingsSectionOther,
          topMargin: 30,
        ),
        SettingsItem(
          title: AppLocalizations.of(context)!.settingsOptionLanguage,
          selector: AdaptiveDropdown(
            items: _languages,
            defaultSelectedIndex:
                context.read<LocalizationService>().currentLocaleIndex,
            onChanged: (newValue) {},
          ),
        ),
      ],
    );
  }
}
