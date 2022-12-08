import 'package:flutter/material.dart';

import '../base/flat.dart';
import '../../widgets/forms/signup_form.dart';
import '../../widgets/button.dart';

class AuthSignUpScreen extends StatelessWidget {
  static const routeName = "/authenticate/sign-up";

  const AuthSignUpScreen({super.key});

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
                      "Welcome!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: const SignUpForm(),
                  ),
                  Button.secondary(
                    "Sign Up",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
