import 'package:flutter/material.dart';

import '../base/flat.dart';
import '../../widgets/forms/login_form.dart';
import '../../widgets/ui/adaptive_button.dart';

class AuthLogInScreen extends StatelessWidget {
  static const routeName = "/authenticate/log-in";

  const AuthLogInScreen({super.key});

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
                      "Welcome back!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: const LogInForm(),
                  ),
                  AdaptiveButton.secondary(
                    "Log In",
                    extended: true,
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
