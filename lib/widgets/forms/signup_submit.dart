import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';
import '../../bloc/database_service.dart';
import '../../bloc/profile_quiz_service.dart';
import '../../bloc/localization_service.dart';

import '../../screens/profile/profile_name_screen.dart';
import '../ui/adaptive_button.dart';
import '../authentication_error_popup.dart';
import '../no_intnernet_popup.dart';
import '../../models/exceptions.dart';

class SignupSubmit extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Stream<String> emailStream;
  final Stream<String> passwordStream;

  const SignupSubmit(
    this.formKey, {
    required this.emailStream,
    required this.passwordStream,
    super.key,
  });

  @override
  State<SignupSubmit> createState() => _SignupSubmitState();
}

class _SignupSubmitState extends State<SignupSubmit> {
  bool _isLoading = false;
  String _email = "";
  String _password = "";

  @override
  void initState() {
    widget.emailStream.listen((email) => _email = email);
    widget.passwordStream.listen((password) => _password = password);

    super.initState();
  }

  void _onRegisterPressed(BuildContext buildContext) async {
    setState(() {
      _isLoading = true;
    });

    final success = widget.formKey.currentState?.validate();
    if (success == null || !success) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    widget.formKey.currentState?.save();
    if (!mounted) return;

    final currentLocale = buildContext.read<LocalizationService>().state;
    try {
      await buildContext
          .read<ProfileQuizService>()
          .loadFromLocale(currentLocale);
      if (!mounted) return;
      await buildContext
          .read<AuthenticationService>()
          .attemptSignUp(_email, _password);
    } on AuthenticationException catch (error) {
      showDialog(
        context: buildContext,
        builder: (_) => AuthenticationErrorPopup(error.responseCode),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } on NoInternetException {
      showDialog(
        context: buildContext,
        builder: (_) => const NoInternetPopup(),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } catch (error) {
      showDialog(
        context: buildContext,
        builder: (_) =>
            const AuthenticationErrorPopup(AuthenticationError.unknown),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (!mounted) return;
    buildContext.read<DatabaseService>().fullReset();
    await buildContext.read<DatabaseService>().initializeUserEntry(
          buildContext.read<AuthenticationService>().state.userId,
        );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    Navigator.of(buildContext)
        .pushNamedAndRemoveUntil(ProfileNameScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
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
    );
  }
}
