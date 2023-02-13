import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/content_outline_service.dart';

import '../../widgets/ui/adaptive_circular_progress_bar.dart';
import '../../widgets/statistics_list.dart';
import '../../widgets/containers/rounded_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  AppLocalizations.of(context)!.statisticsScreenTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              AdaptiveCircularProgressBar(
                context.read<ContentOutlineService>().cumulativeProgress,
                footer: AppLocalizations.of(context)!
                    .statisticsScreenProgressSubtitle,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: StatisticsList(),
              ),
              RoundedCard(
                padding: const EdgeInsets.all(20),
                fillWidth: true,
                fillHeight: false,
                child: Text(
                  AppLocalizations.of(context)!.statisticsScreenDisclaimer,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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
