import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/account_service.dart';

import '../ui/adaptive_button.dart';
import '../ui/adaptive_form_field.dart';
import '../custom_circular_progress_indicator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    value: 1.0,
  );
  late final _fadeAnimation =
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

  bool isLoading = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext buildContext) async {
    await _fadeController.reverse();
    setState(() {
      isLoading = true;
    });
    _fadeController.forward();
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
        ),
        const SizedBox(
          height: 50,
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: isLoading
              ? Text(
                  "...",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              : AdaptiveButton.secondary(
                  AppLocalizations.of(context)!.authSignUpButtonLabel,
                  extended: true,
                  onPressed: () => _onRegisterPressed(context),
                ),
        ),
      ],
    );
  }
}
