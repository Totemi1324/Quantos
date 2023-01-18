import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'auth_signup_screen.dart';
import 'auth_login_screen.dart';
import 'auth_groupaccess_screen.dart';

import '../base/flat.dart';
import '../../widgets/ui/adaptive_button.dart';

class AuthHomeScreen extends StatelessWidget {
  static const routeName = "/authenticate";

  const AuthHomeScreen({super.key});

  Widget _buildAuthOption(BuildContext buildContext,
      {required String description,
      required String buttonLabel,
      required String routeName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: Text(
            description,
            style: Theme.of(buildContext).textTheme.bodyMedium,
          ),
        ),
        const Flexible(
          flex: 1,
          child: SizedBox(),
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.loose,
          child: AdaptiveButton.primary(
            buttonLabel,
            extended: false,
            onPressed: () => Navigator.of(buildContext).pushNamed(routeName),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 330,
                height: 90,
                child: RiveAnimation.asset(
                  'assets/animations/quantos_logo_idle.riv',
                  fit: BoxFit.contain,
                  stateMachines: ['Mixer'],
                ),
              ),
              _buildAuthOption(
                context,
                description: "New here?",
                buttonLabel: "Sign Up",
                routeName: AuthSignUpScreen.routeName,
              ),
              _buildAuthOption(
                context,
                description: "Already on board?",
                buttonLabel: "Log In",
                routeName: AuthLogInScreen.routeName,
              ),
              _buildAuthOption(
                context,
                description: "Part of a classroom or team?",
                buttonLabel: "Enter Access Code",
                routeName: AuthGroupAccessScreen.routeName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
