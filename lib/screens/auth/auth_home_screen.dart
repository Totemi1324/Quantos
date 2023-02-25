import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

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
            enabled: true,
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
              SizedBox(
                width: 330,
                height: 90,
                child: RiveAnimation.asset(
                  Assets.animations.quantosLogoIdle,
                  fit: BoxFit.contain,
                  stateMachines: const ['Mixer'],
                ),
              ),
              _buildAuthOption(
                context,
                description:
                    AppLocalizations.of(context)!.authSignUpDescription,
                buttonLabel:
                    AppLocalizations.of(context)!.authSignUpButtonLabel,
                routeName: AuthSignUpScreen.routeName,
              ),
              _buildAuthOption(
                context,
                description: AppLocalizations.of(context)!.authLogInDescription,
                buttonLabel: AppLocalizations.of(context)!.authLogInButtonLabel,
                routeName: AuthLogInScreen.routeName,
              ),
              _buildAuthOption(
                context,
                description:
                    AppLocalizations.of(context)!.authGroupAccessDescription,
                buttonLabel:
                    AppLocalizations.of(context)!.authGroupAccessButtonLabel,
                routeName: AuthGroupAccessScreen.routeName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
