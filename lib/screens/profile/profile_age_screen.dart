import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import '../../bloc/stores/age_classes_store_service.dart';
import '../../bloc/localization_service.dart';

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

    return BlocProvider(
      create: (context) =>
          AgeClassesStoreService(context.read<LocalizationService>().state),
      child: BlocBuilder<AgeClassesStoreService, Map<int, String>>(
        builder: (context, state) => Flat(
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
                        AppLocalizations.of(context)!
                            .profileAgeScreenInstructions,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: SliderSelectForm(
                        divisions: 3,
                        divisionToString: state,
                        initialDivision: 1,
                        animationAsset: Assets.animations.ageSelection,
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
        ),
      ),
    );
  }
}
