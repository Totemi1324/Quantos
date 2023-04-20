import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quantos/bloc/stores/theme_store_service.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:sdk_int/sdk_int.dart';

import '../bloc/theme_service.dart';
import '../bloc/localization_service.dart';
import '../bloc/content_outline_service.dart';
import '../bloc/text_to_speech_service.dart';
import '../bloc/download_service.dart';
import '../bloc/storage_service.dart';

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
    return BlocProvider(
      create: (context) =>
          ThemeStoreService(context.read<LocalizationService>().state),
      child: BlocBuilder<ThemeStoreService, List<DropdownMenuItem<Brightness>>>(
        builder: (context, state) => BlocListener<LocalizationService, Locale>(
          listener: (context, state) =>
              context.read<ThemeStoreService>().updateStore(state),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionSeparator(
                AppLocalizations.of(context)!.settingsSectionAccessibility,
              ),
              SettingsItem(
                title: AppLocalizations.of(context)!
                    .settingsOptionAccessibilityMode,
                selector: AdaptiveSwitch(
                  defaultEnabled:
                      context.read<ThemeService>().accessibilityModeActive,
                  onToggle: (newValue) => context
                      .read<ThemeService>()
                      .toggleAccessibilityMode(newValue),
                ),
              ),
              SettingsItem(
                title:
                    AppLocalizations.of(context)!.settingsOptionColorblindTheme,
                selector: AdaptiveSwitch(
                  defaultEnabled:
                      context.read<ThemeService>().colorblindModeActive,
                  onToggle: (newValue) => context
                      .read<ThemeService>()
                      .toggleColorblindMode(newValue),
                ),
              ),
              SectionSeparator(
                AppLocalizations.of(context)!.settingsSectionVisuals,
                topMargin: 30,
              ),
              SettingsItem(
                title: AppLocalizations.of(context)!.settingsOptionTheme,
                selector: AdaptiveDropdown(
                  enabled:
                      !context.watch<ThemeService>().accessibilityModeActive,
                  items: state,
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
                  onChanged: (newValue) async {
                    final newLocale = newValue as Locale;
                    final localizationService =
                        context.read<LocalizationService>();
                    final contentOutlineService =
                        context.read<ContentOutlineService>();
                    final textToSpeechService =
                        context.read<TextToSpeechService>();
                    final downloadService = context.read<DownloadService>();
                    final storageService = context.read<StorageService>();

                    localizationService.setLocale(newLocale);
                    await contentOutlineService.loadFromLocale(newLocale);
                    if (UniversalPlatform.isAndroid) {
                      if (await SDKInt.currentSDKVersion < 30) {
                        await textToSpeechService.setLanguage(newLocale);
                      }
                    }

                    await storageService.getDownloadLocalization(newLocale);
                    final currentDownloadData = storageService.state.content;
                    String? fallbackDownloadData;
                    if (newLocale.languageCode != "en") {
                      await storageService
                          .getDownloadLocalization(const Locale("en"));
                      fallbackDownloadData = storageService.state.content;
                    }

                    downloadService.loadFromLocale(
                        currentDownloadData, fallbackDownloadData);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
