import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import '../profile/profile_name_screen.dart';

import '../../widgets/part_separator.dart';
import '../../widgets/account_settings_item.dart';

class ProfileScreen extends StatelessWidget {
  final String? name = "Tamas";
  final String age = "19-28";
  final String? team = "Universität Regensburg";

  const ProfileScreen({super.key});

  Widget _buildUserInfo(
    BuildContext buildContext, {
    String? name,
    required String age,
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
    return Padding(
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
                  backgroundImage: Assets.images.profileBackground.provider(),
                  foregroundImage: Assets.images.profileForeground.provider(),
                  radius: 70,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: _buildUserInfo(
                  context,
                  name: name,
                  age: age,
                  team: team,
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
                    AppLocalizations.of(context)!.profileScreenOptionGroups,
                    onTap: () => _sendWorkInProgressMessage(context),
                  ),
                  AccountSettingsItem(
                    AppLocalizations.of(context)!.profileScreenOptionPersonal,
                    onTap: () => Navigator.of(context)
                        .pushNamed(ProfileNameScreen.routeName),
                  ),
                  AccountSettingsItem(
                    AppLocalizations.of(context)!.profileScreenOptionPassword,
                    onTap: () => _sendWorkInProgressMessage(context),
                  ),
                  AccountSettingsItem(
                    AppLocalizations.of(context)!.profileScreenOptionDelete,
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
    );
  }
}
