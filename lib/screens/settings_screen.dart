import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './info_screen.dart';
import './help_screen.dart';

import './base/flat.dart';
import '../widgets/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 50),
                  child: Text(
                    AppLocalizations.of(context)!.settingsScreenTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: const SettingsList(),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(InfoScreen.routeName),
                  child: Text(
                    AppLocalizations.of(context)!.infoScreenTitle,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(HelpScreen.routeName),
                  child: Text(
                    AppLocalizations.of(context)!.helpScreenTitle,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
