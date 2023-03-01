import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import '../../bloc/stores/experience_classes_store_service.dart';
import '../../bloc/localization_service.dart';
import '../../bloc/content_outline_service.dart';
import '../../bloc/database_service.dart';
import '../../bloc/authentication_service.dart';

import '../base/flat.dart';
import '../base/home.dart';
import '../../screens/loading_screen.dart';
import '../../models/user_data.dart';
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
                        animationAsset: Assets.animations.experienceSelection,
                        stateMachine: "ExperienceClasses",
                        scalarInput: "experience_class",
                        onChanged: (selected) => context
                            .read<DatabaseService>()
                            .updateExperience(Experience.values[selected]),
                      ),
                    ),
                    AdaptiveButton.primary(
                      AppLocalizations.of(context)!.readyButtonLabel,
                      extended: true,
                      enabled: true,
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (buildContext) => LoadingScreen(
                            Future(
                              () async {
                                buildContext
                                .read<ContentOutlineService>()
                                .loadFromLocale(
                                  buildContext
                                      .read<LocalizationService>()
                                      .state,
                                );
                                await buildContext
                                .read<DatabaseService>().
                                updateProfileInfo(
                                  buildContext
                                      .read<AuthenticationService>()
                                      .state.userId,
                                );
                              }
                            ),
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
