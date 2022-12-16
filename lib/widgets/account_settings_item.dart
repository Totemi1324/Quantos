import 'package:flutter/material.dart';

import './containers/panel_card.dart';

class AccountSettingsItem extends StatelessWidget {
  final String option;
  final Color? optionColor;
  final VoidCallback onTap;

  const AccountSettingsItem(
    this.option, {
    this.optionColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: PanelCard(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Text(
          option,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color:
                    optionColor ?? Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
