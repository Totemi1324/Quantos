import 'package:flutter/material.dart' hide ThemeMode;

import './section_separator.dart';
import './settings_item.dart';
import './ui/adaptive_switch.dart';
import './ui/adaptive_dropdown.dart';

enum ThemeMode {
  dark,
  light,
}

class SettingsList extends StatelessWidget {
  final List<DropdownMenuItem> _themes = const [
    DropdownMenuItem(
      value: ThemeMode.dark,
      child: Text("Dark"),
    ),
    DropdownMenuItem(
      value: ThemeMode.light,
      child: Text("Light"),
    ),
  ];
  final List<DropdownMenuItem> _languages = const [
    DropdownMenuItem(
      value: "DE",
      child: Text("Deutsch"),
    ),
    DropdownMenuItem(
      value: "EN",
      child: Text("English"),
    ),
  ];

  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionSeparator("Accessibility options"),
        SettingsItem(
          title: "Accessibility mode",
          selector: AdaptiveSwitch(
            defaultEnabled: false,
            onToggle: () {},
          ),
        ),
        SettingsItem(
          title: "Enable colorblind theme",
          selector: AdaptiveSwitch(
            defaultEnabled: false,
            onToggle: () {},
          ),
        ),
        const SectionSeparator(
          "Visuals",
          topMargin: 30,
        ),
        SettingsItem(
          title: "Choose theme",
          selector: AdaptiveDropdown(
            items: _themes,
            defaultSelectedIndex: 0,
            onChanged: (newValue) {},
          ),
        ),
        const SectionSeparator(
          "Others",
          topMargin: 30,
        ),
        SettingsItem(
          title: "Language",
          selector: AdaptiveDropdown(
            items: _languages,
            defaultSelectedIndex: 1,
            onChanged: (newValue) {},
          ),
        ),
      ],
    );
  }
}
