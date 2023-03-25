import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';

import '../bloc/theme_service.dart';
import '../bloc/localization_service.dart';

import '../models/titled_element.dart';
import './containers/rounded_card.dart';
import './canvas/heatmap_chart.dart';
import './performace_chart.dart';
import './progress_list.dart';

class StatisticsList extends StatefulWidget {
  const StatisticsList({super.key});

  @override
  State<StatisticsList> createState() => _StatisticsListState();
}

class _StatisticsListState extends State<StatisticsList> {
  final int elementCount = 3;

  TitledElement _buildElement(
      ThemeData theme, AppLocalizations localization, int index) {
    switch (index) {
      case 0:
        return TitledElement(
          title: localization.statisticsListElementActivityTitle,
          element: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.statisticsListElementActivitySubtitle,
                style: theme.textTheme.labelSmall,
              ),
              const HeatmapChart(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    localization.statisticsListElementActivityOnline,
                    style: theme.textTheme.labelSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.secondary,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    localization.statisticsListElementActivityOffline,
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return TitledElement(
          title: localization.statisticsListElementPerformanceTitle,
          element: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.statisticsListElementPerformanceSubtitle,
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              const PerformanceChart(),
              Text(
                localization.statisticsListElementPerformanceLegend,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        );
      case 2:
        return TitledElement(
          title: localization.statisticsListElementProgressTitle,
          element: const ProgressList(),
        );
      default:
        return TitledElement.empty();
    }
  }

  Future _readOutContent(int index) async {
    final player = AudioPlayer();

    switch (index) {
      case 0:
        await player.play(AssetSource("sounds/heatmap.mp3"));
        break;
      case 1:
        await player.play(AssetSource("sounds/linechart.mp3"));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeService, ThemeData>(
          listener: (context, state) => setState(() {}),
        ),
        BlocListener<LocalizationService, Locale>(
          listener: (context, state) => setState(() {}),
        ),
      ],
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: elementCount,
        itemBuilder: (context, index) {
          final activeTheme = context.read<ThemeService>().state;
          final localization = AppLocalizations.of(context)!;
          final item = _buildElement(activeTheme, localization, index);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: RoundedCard(
              fillWidth: true,
              fillHeight: false,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: activeTheme.textTheme.labelMedium,
                      ),
                      if (index != 2)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async =>
                                  await _readOutContent(index),
                              tooltip:
                                  AppLocalizations.of(context)!.tooltipReadOut,
                              icon: Icon(
                                Icons.record_voice_over_rounded,
                                color: activeTheme.colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  item.element
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
