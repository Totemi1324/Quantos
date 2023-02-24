import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/ui/adaptive_message_dialog.dart';
import '../models/exceptions.dart';

class AuthenticationErrorPopup extends StatelessWidget {
  final AuthenticationError errorType;

  const AuthenticationErrorPopup(this.errorType, {super.key});

  String _getErrorMessage(BuildContext buildContext) {
    switch (errorType) {
      case AuthenticationError.emailExists:
        return AppLocalizations.of(buildContext)!
            .authenticationErrorEmailExists;
      case AuthenticationError.tooManyAttempts:
        return AppLocalizations.of(buildContext)!
            .authenticationErrorTooManyAttempts;
      case AuthenticationError.emailNotFound:
        return AppLocalizations.of(buildContext)!
            .authenticationErrorEmailNotFound;
      case AuthenticationError.invalidPassword:
        return AppLocalizations.of(buildContext)!
            .authenticationErrorInvalidPassword;
      case AuthenticationError.userDisabled:
        return AppLocalizations.of(buildContext)!
            .authenticationErrorUserDisabled;
      case AuthenticationError.unknown:
        return AppLocalizations.of(buildContext)!.authenticationErrorUnknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveMessageDialog(
      message: Text(
        _getErrorMessage(context),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
