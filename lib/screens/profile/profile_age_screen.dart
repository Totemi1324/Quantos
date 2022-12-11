import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../base/flat.dart';
import './profile_experience_screen.dart';
import '../../widgets/forms/select_form.dart';
import '../../widgets/button.dart';

class ProfileAgeScreen extends StatelessWidget {
  static const routeName = "/profile/age";
  final Map<int, String> _stringForSliderDivision = {
    0: "15-18",
    1: "19-28",
    2: "29-59",
    3: "60+",
  };

  ProfileAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final profileName = args as String?;

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
                    "And how old are\nyou${profileName != null ? ", $profileName" : ""}?",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "We need this information to choose the optimal learning contents for you.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: SliderSelectForm(
                    divisions: 3,
                    divisionToString: _stringForSliderDivision,
                    initialDivision: 1,
                    animationAsset: "assets/animations/age_selection.riv",
                    stateMachine: "AgeClasses",
                  ),
                ),
                Button.primary(
                  "Confirm",
                  extended: true,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ProfileExperienceScreen.routeName),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
