import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/ui/adaptive_message_dialog.dart';

class NoInternetPopup extends StatelessWidget {
  const NoInternetPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveMessageDialog(
      message: Text(
        AppLocalizations.of(context)!.noInternetConnectionErrorMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
