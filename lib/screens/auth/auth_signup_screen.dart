import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quantos/widgets/forms/signup_submit.dart';

import '../base/flat.dart';
import '../../widgets/forms/signup_form.dart';

class AuthSignUpScreen extends StatelessWidget {
  static const routeName = "/authenticate/sign-up";
  final formKey = GlobalKey<FormState>();
  final emailController = StreamController<String>();
  final passwordController = StreamController<String>();

  AuthSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Flat(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
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
                      formKey,
                      onEmailSave: (newEmail) => emailController.add(newEmail),
                      onPasswordSave: (newPassword) => passwordController.add(newPassword),
                    ),
                  ),
                  SignupSubmit(
                    formKey,
                    emailStream: emailController.stream,
                    passwordStream: passwordController.stream,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
