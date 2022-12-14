import 'package:flutter/material.dart';

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
                    "Settings",
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
                    "App Information",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(HelpScreen.routeName),
                  child: Text(
                    "Help Center",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 15,
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
