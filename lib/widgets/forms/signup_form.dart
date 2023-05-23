import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/adaptive_form_field.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String) onEmailSave;
  final void Function(String) onPasswordSave;
  final Function(String?) onPasswordChange;
  final VoidCallback onPasswordTap;

  const SignUpForm(
    this.formKey, {
    required this.onEmailSave,
    required this.onPasswordSave,
    required this.onPasswordChange,
    required this.onPasswordTap,
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  static final RegExp emailFormat = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final RegExp passwordFormat = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{10,}$");

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String? _passwordCache;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Form(
        key: widget.formKey,
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
              onSaved: (newValue) {
                if (newValue != null) {
                  widget.onEmailSave(newValue);
                }
              },
              validator: (value) {
                if (value == null || value == "") {
                  return AppLocalizations.of(context)
                          ?.validationFailEmailMissing ??
                      "";
                }
                return emailFormat.hasMatch(value)
                    ? null
                    : (AppLocalizations.of(context)
                            ?.validationFailEmailIncorrectFormat ??
                        "");
              },
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            AdaptiveFormField.password(
              AppLocalizations.of(context)!.authFormPassword,
              isFinalField: false,
              thisField: _passwordFocusNode,
              nextField: _confirmPasswordFocusNode,
              onSaved: (newValue) {
                if (newValue != null) {
                  widget.onPasswordSave(newValue);
                }
              },
              onChanged: widget.onPasswordChange,
              onTap: widget.onPasswordTap,
              validator: (value) {
                _passwordCache = value;
                if (value == null || value == "") {
                  return "";
                }
                return passwordFormat.hasMatch(value) ? null : "";
              },
            ),
            AdaptiveFormField.password(
              AppLocalizations.of(context)!.authFormConfirmPassword,
              prefixIcon: Icons.spellcheck_rounded,
              isFinalField: true,
              thisField: _confirmPasswordFocusNode,
              onSaved: (_) {},
              validator: (value) {
                return value == _passwordCache
                    ? null
                    : (AppLocalizations.of(context)
                            ?.validationFailConfirmPasswordNoMatch ??
                        "");
              },
            )
          ],
        ),
      ),
    );
  }
}
