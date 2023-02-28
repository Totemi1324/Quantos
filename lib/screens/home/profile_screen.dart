import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';
import '../../bloc/profile_info_service.dart';
import '../../bloc/localization_service.dart';
import '../../bloc/stores/age_classes_store_service.dart';
import '../../bloc/stores/experience_classes_store_service.dart';

import '../profile/profile_name_screen.dart';
import '../splash_screen.dart';
import '../../widgets/part_separator.dart';
import '../../widgets/account_settings_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildUserInfo(
    BuildContext buildContext, {
    required String age,
    required String experience,
    String? name,
    String? team,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (name != null)
          Text(
            name,
            style: Theme.of(buildContext).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        if (name != null)
          const SizedBox(
            height: 10,
          ),
        Text(
          age,
          style: Theme.of(buildContext).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          experience,
          style: Theme.of(buildContext).textTheme.labelLarge,
        ),
        if (team != null)
          const SizedBox(
            height: 10,
          ),
        if (team != null)
          Text(
            AppLocalizations.of(buildContext)!.profileScreenAffiliation(team),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  void _sendWorkInProgressMessage(BuildContext buildContext) =>
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(buildContext)!.workInProgressMessage,
            style: Theme.of(buildContext).textTheme.bodySmall,
          ),
          backgroundColor: Theme.of(buildContext).colorScheme.surface,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final profileInfo = context.read<ProfileInfoService>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AgeClassesStoreService>(
          create: (_) =>
              AgeClassesStoreService(context.read<LocalizationService>().state),
        ),
        BlocProvider<ExperienceClassesStoreService>(
          create: (_) => ExperienceClassesStoreService(
              context.read<LocalizationService>().state),
        ),
      ],
      child: BlocBuilder<AgeClassesStoreService, Map<int, String>>(
        builder: (context, ageClasses) =>
            BlocBuilder<ExperienceClassesStoreService, Map<int, String>>(
          builder: (context, experienceClasses) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 10),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            Assets.images.profileBackground.provider(),
                        foregroundImage:
                            Assets.images.profileForeground.provider(),
                        radius: 70,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: _buildUserInfo(
                        context,
                        age: ageClasses[profileInfo.age.index] ?? "NaN",
                        experience:
                            experienceClasses[profileInfo.experience.index] ??
                                "NaN",
                        name: profileInfo.name,
                        team: profileInfo.name == "Tamas"
                            ? profileInfo.team
                            : null,
                      ),
                    ),
                    PartSeparator(
                      AppLocalizations.of(context)!.profileScreenOptionsSection,
                      verticalMargin: 10,
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AccountSettingsItem(
                          AppLocalizations.of(context)!
                              .profileScreenOptionGroups,
                          onTap: () => _sendWorkInProgressMessage(context),
                        ),
                        AccountSettingsItem(
                          AppLocalizations.of(context)!
                              .profileScreenOptionPersonal,
                          onTap: () => Navigator.of(context)
                              .pushNamed(ProfileNameScreen.routeName),
                        ),
                        AccountSettingsItem(
                          AppLocalizations.of(context)!
                              .profileScreenOptionPassword,
                          onTap: () => _sendWorkInProgressMessage(context),
                        ),
                        AccountSettingsItem(
                          AppLocalizations.of(context)!
                              .profileScreenOptionLogout,
                          optionColor: Theme.of(context).colorScheme.error,
                          onTap: () {
                            context.read<AuthenticationService>().logOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              SplashScreen.routeName,
                              (_) => false,
                            );
                          },
                        ),
                        AccountSettingsItem(
                          AppLocalizations.of(context)!
                              .profileScreenOptionDelete,
                          optionColor: Theme.of(context).colorScheme.error,
                          onTap: () => _sendWorkInProgressMessage(context),
                        ),
                      ],
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
