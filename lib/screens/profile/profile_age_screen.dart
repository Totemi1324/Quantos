import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../base/flat.dart';
import '../../widgets/forms/select_form.dart';
import '../../widgets/button.dart';

Map<int, String> stringForSliderDivision = {
  0: "15-18",
  1: "19-28",
  2: "29-59",
  3: "60+",
};

class ProfileAgeScreen extends StatelessWidget {
  static const routeName = "/profile/age";

  const ProfileAgeScreen({super.key});

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
                    divisionToString: stringForSliderDivision,
                    initialDivision: 1,
                    stateMachine: const RiveAnimation.asset(
                      'assets/animations/age_selection.riv',
                      fit: BoxFit.fitWidth,
                      stateMachines: ['AgeClasses'],
                    ),
                  ),
                ),
                Button.primary(
                  "Confirm",
                  extended: true,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
