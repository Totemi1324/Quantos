import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../base/flat.dart';
import '../../widgets/button.dart';

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
          child: Button.primary(
            buttonLabel,
            onPressed: () {},
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
                width: 360,
                height: 80,
                child: RiveAnimation.asset(
                  'assets/animations/quantos_logo_idle.riv',
                  fit: BoxFit.fitWidth,
                  stateMachines: ['Mixer'],
                ),
              ),
              _buildAuthOption(
                context,
                description: "New here?",
                buttonLabel: "Sign Up",
                routeName: "/authenticate/sign-up",
              ),
              _buildAuthOption(
                context,
                description: "Already on board?",
                buttonLabel: "Log In",
                routeName: "/authenticate/log-in",
              ),
              _buildAuthOption(
                context,
                description: "Part of a classroom or team?",
                buttonLabel: "Enter Access Code",
                routeName: "/authenticate/group-access",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
