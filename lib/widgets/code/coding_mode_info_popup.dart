import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/adaptive_message_dialog.dart';

class CodingModeInfoPopup extends StatelessWidget {
  const CodingModeInfoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveMessageDialog(
      title: AppLocalizations.of(context)!.codingInfoTitle,
      message: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.codingModeSimulator,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.codingInfoSimulator,
            ),
            TextSpan(
              text: "\n\n${AppLocalizations.of(context)!.codingModeAnnealer}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.codingInfoAnnealer,
            ),
          ],
        ),
      ),
    );
  }
}
