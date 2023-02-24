import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';

import '../ui/adaptive_button.dart';
import '../ui/adaptive_form_field.dart';
import '../../models/exceptions.dart';
import '../../widgets/authentication_error_popup.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  static final RegExp emailFormat = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final RegExp passwordFormat = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{10,}$");

  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;
  String _email = "";
  String _password = "";
  String? _passwordCache;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext buildContext) async {
    setState(() {
      _isLoading = true;
    });

    final success = _formKey.currentState?.validate();
    if (success == null || !success) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _formKey.currentState?.save();
    if (!mounted) return;

    try {
      await context
          .read<AuthenticationService>()
          .attemptSignUp(_email, _password);
    } on AuthenticationException catch (error) {
      showDialog(
        context: context,
        builder: (_) => AuthenticationErrorPopup(error.responseCode),
        barrierDismissible: true,
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => const AuthenticationErrorPopup(AuthenticationError.unknown),
        barrierDismissible: true,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
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
                onSaved: (newValue) {
                  if (newValue != null) {
                    _email = newValue;
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
                    _password = newValue;
                  }
                },
                validator: (value) {
                  _passwordCache = value;
                  if (value == null || value == "") {
                    return AppLocalizations.of(context)
                            ?.validationFailPasswordMissing ??
                        "";
                  }
                  return passwordFormat.hasMatch(value)
                      ? null
                      : (AppLocalizations.of(context)
                              ?.validationFailPasswordNotSufficient ??
                          "");
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
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
        const SizedBox(
          height: 50,
        ),
        AnimatedCrossFade(
          crossFadeState:
              _isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 150),
          firstCurve: Curves.ease,
          secondCurve: Curves.ease,
          firstChild: AdaptiveButton.secondary(
            AppLocalizations.of(context)!.authSignUpButtonLabel,
            extended: true,
            onPressed: () => _onRegisterPressed(context),
            enabled: true,
          ),
          secondChild: AdaptiveButton.secondary(
            AppLocalizations.of(context)!.authSignUpButtonLabel,
            extended: true,
            onPressed: () => _onRegisterPressed(context),
            enabled: false,
          ),
        ),
      ],
    );
  }
}
