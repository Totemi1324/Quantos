import 'package:flutter/material.dart';
import 'package:quantos/screens/loading_screen.dart';

import '../base/flat.dart';
import '../home_screen.dart';
import '../../widgets/forms/select_form.dart';
import '../../widgets/button.dart';

class ProfileExperienceScreen extends StatelessWidget {
  static const routeName = "/profile/experience";
  final Map<int, String> _stringForSliderDivision = {
    0: "Beginner",
    1: "Advanced",
    2: "Skilled",
  };

  ProfileExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    "How would you describe yourself?",
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
                    divisions: 2,
                    divisionToString: _stringForSliderDivision,
                    initialDivision: 0,
                    animationAsset: "assets/animations/age_selection.riv",
                    stateMachine: "AgeClasses",
                  ),
                ),
                Button.primary(
                  "I'm ready",
                  extended: true,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (_) =>
                              const LoadingScreen(HomeScreen.routeName)),
                      (_) => false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
