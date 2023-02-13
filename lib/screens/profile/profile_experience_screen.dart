import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/stores/experience_classes_store_service.dart';
import '../../bloc/localization_service.dart';

import '../base/flat.dart';
import '../base/home.dart';
import '../../screens/loading_screen.dart';
import '../../widgets/forms/slider_select_form.dart';
import '../../widgets/ui/adaptive_button.dart';

class ProfileExperienceScreen extends StatelessWidget {
  static const routeName = "/profile/experience";

  const ProfileExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExperienceClassesStoreService(
          context.read<LocalizationService>().state),
      child: BlocBuilder<ExperienceClassesStoreService, Map<int, String>>(
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
                        AppLocalizations.of(context)!
                            .profileExperienceScreenTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!
                            .profileExperienceScreenInstructions,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: SliderSelectForm(
                        divisions: 2,
                        divisionToString: state,
                        initialDivision: 0,
                        animationAsset: "assets/animations/age_selection.riv",
                        stateMachine: "AgeClasses",
                      ),
                    ),
                    AdaptiveButton.primary(
                      AppLocalizations.of(context)!.readyButtonLabel,
                      extended: true,
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => LoadingScreen(
                            Future.delayed(const Duration(milliseconds: 2000)),
                            Home.routeName,
                          ),
                        ),
                        (_) => false,
                      ),
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
