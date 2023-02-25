import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';
import '../../bloc/content_outline_service.dart';
import '../../bloc/localization_service.dart';

import '../../screens/base/home.dart';
import '../../screens/loading_screen.dart';
import '../ui/adaptive_form_field.dart';
import '../ui/adaptive_button.dart';
import '../../models/exceptions.dart';
import '../authentication_error_popup.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  String _email = "";
  String _password = "";

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSignInPressed(BuildContext buildContext) async {
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    if (!mounted) return;

    try {
      await context
          .read<AuthenticationService>()
          .attemptLogIn(_email, _password);
    } on AuthenticationException catch (error) {
      showDialog(
        context: context,
        builder: (_) => AuthenticationErrorPopup(error.responseCode),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) =>
            const AuthenticationErrorPopup(AuthenticationError.unknown),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    Navigator.of(buildContext).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (buildContext) => LoadingScreen(
          Future(
            () => buildContext.read<ContentOutlineService>().loadFromLocale(
                  buildContext.read<LocalizationService>().state,
                ),
          ),
          Home.routeName,
        ),
      ),
      (_) => false,
    );
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
          AnimatedCrossFade(
            crossFadeState: _isLoading
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 150),
            firstCurve: Curves.ease,
            secondCurve: Curves.ease,
            firstChild: AdaptiveButton.secondary(
              AppLocalizations.of(context)!.authLogInButtonLabel,
              extended: true,
              onPressed: () => _onSignInPressed(context),
              enabled: true,
            ),
            secondChild: AdaptiveButton.secondary(
              AppLocalizations.of(context)!.authLogInButtonLabel,
              extended: true,
              onPressed: () => _onSignInPressed(context),
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
