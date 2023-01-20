import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base/flat.dart';
import './profile_experience_screen.dart';
import '../../widgets/forms/slider_select_form.dart';
import '../../widgets/ui/adaptive_button.dart';

class ProfileAgeScreen extends StatelessWidget {
  static const routeName = "/profile/age";

  const ProfileAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final profileName = args as String?;

    final Map<int, String> stringForSliderDivision = { //TODO
      0: AppLocalizations.of(context)?.profileAgeScreenSliderClass1 ?? "15-18",
      1: AppLocalizations.of(context)?.profileAgeScreenSliderClass2 ?? "19-28",
      2: AppLocalizations.of(context)?.profileAgeScreenSliderClass3 ?? "29-59",
      3: AppLocalizations.of(context)?.profileAgeScreenSliderClass4 ?? "60+",
    };

    return Flat(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    profileName == null
                        ? AppLocalizations.of(context)!
                            .profileAgeScreenTitleWithoutName
                        : AppLocalizations.of(context)!
                            .profileAgeScreenTitleWithName(profileName),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    AppLocalizations.of(context)!.profileAgeScreenInstructions,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: SliderSelectForm(
                    divisions: 3,
                    divisionToString: stringForSliderDivision,
                    initialDivision: 1,
                    animationAsset: "assets/animations/age_selection.riv",
                    stateMachine: "AgeClasses",
                  ),
                ),
                AdaptiveButton.primary(
                  AppLocalizations.of(context)!.confirmButtonLabel,
                  extended: true,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ProfileExperienceScreen.routeName),
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
