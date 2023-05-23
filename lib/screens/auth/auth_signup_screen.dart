import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:quantos/widgets/forms/signup_submit.dart';
import 'package:rive/rive.dart';

import '../base/flat.dart';
import '../../widgets/forms/signup_form.dart';

class AuthSignUpScreen extends StatefulWidget {
  static const routeName = "/authenticate/sign-up";

  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  SMITrigger? _passwordTyping;
  SMITrigger? _formValid;
  SMITrigger? _formInvalid;

  void _onInit(Artboard artboard) {
    var controller =
        StateMachineController.fromArtboard(artboard, "PasswordStates")
            as StateMachineController;
    artboard.addController(controller);
    _passwordTyping = controller.findInput<bool>("passwordTyping") as SMITrigger;
    _formValid = controller.findInput<bool>("formInvalid") as SMITrigger;
    _formInvalid = controller.findInput<bool>("formInvalid") as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Flat(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 50),
                  child: Text(
                    AppLocalizations.of(context)!.authSignUpScreenTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: SignUpForm(
                    _formKey,
                    onEmailSave: (newEmail) => _emailController.add(newEmail),
                    onPasswordSave: (newPassword) =>
                        _passwordController.add(newPassword),
                  ),
                ),
                Expanded(
                  child: RiveAnimation.asset(
                    Assets.animations.passwordAssistant,
                    fit: BoxFit.contain,
                    onInit: _onInit,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: SignupSubmit(
                    _formKey,
                    emailStream: _emailController.stream,
                    passwordStream: _passwordController.stream,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
