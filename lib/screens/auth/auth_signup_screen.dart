import 'package:flutter/material.dart';

import '../base/flat.dart';
import '../../widgets/forms/signup_form.dart';

class AuthSignUpScreen extends StatelessWidget {
  static const routeName = "/authenticate/sign-up";

  const AuthSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 30),
                child: Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
