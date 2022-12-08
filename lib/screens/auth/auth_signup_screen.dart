import 'package:flutter/material.dart';

import '../base/flat.dart';

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
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
