import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/adaptive_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AdaptiveFormField.icon(
            AppLocalizations.of(context)!.authFormEmail,
            prefixIcon: Icons.alternate_email_rounded,
            autocorrect: false,
            enableSuggestions: true,
            isFinalField: false,
            nextField: _passwordFocusNode,
          ),
          AdaptiveFormField.password(
            AppLocalizations.of(context)!.authFormPassword,
            isFinalField: false,
            thisField: _passwordFocusNode,
            nextField: _confirmPasswordFocusNode,
          ),
          AdaptiveFormField.password(
            AppLocalizations.of(context)!.authFormConfirmPassword,
            prefixIcon: Icons.spellcheck_rounded,
            isFinalField: true,
            thisField: _confirmPasswordFocusNode,
          )
        ],
      ),
    );
  }
}
