import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_info_service.dart';

import '../../widgets/notifications/notification_bar.dart';
import '../../widgets/part_separator.dart';
import '../../widgets/lection_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? profileName = context.read<DatabaseService>().state.name;

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
                child: Text(
                  profileName == null
                      ? AppLocalizations.of(context)!.homeScreenTitleWithoutName
                      : AppLocalizations.of(context)!
                          .homeScreenTitleWithName(profileName),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: NotificationBar(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              PartSeparator(
                AppLocalizations.of(context)!.homeScreenLectionsSection,
                verticalMargin: 10,
              ),
              const LectionList(),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
