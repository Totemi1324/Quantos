import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/theme_service.dart';
import '../bloc/localization_service.dart';
import '../bloc/text_to_speech_service.dart';

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

  Future _readOutContent(BuildContext buildContext, int index) async {
    final currentLocale = buildContext.read<LocalizationService>().state;
    final ttsService = buildContext.read<TextToSpeechService>();

    if (index == 0) {
      switch (currentLocale.languageCode) {
        case "de":
          await ttsService.speak(
              "Du warst in den letzten 30 Tagen an 1 Tag online. Montag, der 27. März.");
          break;
        case "en":
        default:
          await ttsService.speak(
              "Out of the last 30 days, you were online on 1 day. Monday, march 27.");
          break;
      }
    }
    if (index == 1) {
      switch (currentLocale.languageCode) {
        case "de":
          await ttsService.speak(
              "In den letzten 7 Tagen hast du folgende Leistung erbracht: Dienstag, 0 Einheiten, Mittwoch, 0 Einheiten, Donnerstag, 0 Einheiten, Freitag, 0 Einheiten, Samstag, 0 Einheiten, Sonntag, 0 Einheiten, Montag, 2 Einheiten.");
          break;
        case "en":
        default:
          await ttsService.speak(
              "In the last 7 days, you performed the following: Tuesday, 0 lessons, Wednesday, 0 lessons, Thursday, 0 lessons, Friday, 0 lessons, Saturday, 0 lessons, Sunday, 0 lessons, Monday, 2 lessons.");
          break;
      }
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
                              onPressed: () async => await _readOutContent(context, index),
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
