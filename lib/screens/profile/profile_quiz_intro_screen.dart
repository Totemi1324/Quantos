import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:rive/rive.dart';

import '../../bloc/database_service.dart';

import '../base/flat.dart';
import '../../widgets/ui/adaptive_button.dart';
import './profile_quiz_screen.dart';

class ProfileQuizIntroScreen extends StatelessWidget {
  static const routeName = "/profile/quiz-intro";

  const ProfileQuizIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileName = context.read<DatabaseService>().state.name;

    return Flat(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: UniversalPlatform.isWeb
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    profileName == null
                        ? AppLocalizations.of(context)!
                            .profileQuizIntroScreenTitleWithoutName
                        : AppLocalizations.of(context)!
                            .profileQuizIntroScreenTitleWithName(profileName),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    AppLocalizations.of(context)!
                        .profileQuizIntroScreenInstructions,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 300,
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: RiveAnimation.asset(
                      Assets.animations.assessmentQuiz,
                      fit: BoxFit.contain,
                      stateMachines: const ["IntroState"],
                    ),
                  ),
                ),
                AdaptiveButton.primary(
                  AppLocalizations.of(context)!.confirmButtonLabel,
                  extended: true,
                  enabled: true,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ProfileQuizScreen.routeName),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
