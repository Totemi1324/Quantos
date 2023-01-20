import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';
import '../ui/adaptive_form_field.dart';

class TokenInput extends StatelessWidget {
  const TokenInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartSeparator(
          AppLocalizations.of(context)!.codingTokenFormFieldSectionTitle,
          verticalMargin: 20,
        ),
        PanelCard(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.codingTokenFormFieldTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              AdaptiveFormField.password(
                AppLocalizations.of(context)!.codingTokenFormField,
                isFinalField: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
