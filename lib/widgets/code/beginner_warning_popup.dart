import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/adaptive_message_dialog.dart';

class BeginnerWarningPopup extends StatelessWidget {
  const BeginnerWarningPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveMessageDialog(
      title: AppLocalizations.of(context)!.codingWarningTitle,
      message: Text(
        AppLocalizations.of(context)!.codingWarningMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
