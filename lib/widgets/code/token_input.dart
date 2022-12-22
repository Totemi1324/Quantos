import 'package:flutter/material.dart';

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
        const PartSeparator(
          "Authentication",
          verticalMargin: 20,
        ),
        PanelCard(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your API token:",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              AdaptiveFormField.password(
                "Paste your token here",
                isFinalField: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
