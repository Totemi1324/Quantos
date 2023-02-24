import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';

import '../ui/adaptive_form_field.dart';
import '../ui/adaptive_button.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    value: 1.0,
  );
  late final _fadeAnimation =
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

  bool _isLoading = false;
  String _email = "";
  String _password = "";

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSignInPressed(BuildContext buildContext) async {
    await _fadeController.reverse();
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    if (!mounted) return;
    await context.read<AuthenticationService>().attemptLogIn(_email, _password);

    _fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AdaptiveFormField.icon(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AdaptiveFormField.password(
              AppLocalizations.of(context)!.authFormPassword,
              isFinalField: true,
              thisField: _passwordFocusNode,
              onSaved: (newValue) {
                if (newValue != null) {
                  _password = newValue;
                }
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: _isLoading
                ? Text(
                    "...",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                : AdaptiveButton.secondary(
                    AppLocalizations.of(context)!.authLogInButtonLabel,
                    extended: true,
                    onPressed: () => _onSignInPressed(context),
                  ),
          )
        ],
      ),
    );
  }
}
