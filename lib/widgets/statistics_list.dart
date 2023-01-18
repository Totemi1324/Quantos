import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_service.dart';

import '../models/titled_element.dart';
import './containers/rounded_card.dart';
import './canvas/line_chart.dart';
import './canvas/heatmap_chart.dart';
import './progress_list.dart';

class StatisticsList extends StatefulWidget {

  const StatisticsList({super.key});

  @override
  State<StatisticsList> createState() => _StatisticsListState();
}

class _StatisticsListState extends State<StatisticsList> {
  final int elementCount = 3;

  TitledElement _buildElement(ThemeData theme, int index) {
    switch (index) {
      case 0:
        return TitledElement(
          title: "Activity",
          element: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "this month",
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
                    "online",
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
                    "offline",
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return TitledElement(
          title: "Performace",
          element: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "in the last 7 days",
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              const LineChart(),
              Text(
                "completed lessons per day",
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        );
      case 2:
        return const TitledElement(
          title: "Progress",
          element: ProgressList(),
        );
      default:
        return TitledElement.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeService, ThemeData>(
      listener: (context, state) => setState(() {}),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: elementCount,
        itemBuilder: (context, index) {
          ThemeData activeTheme = context.read<ThemeService>().state;
          TitledElement item = _buildElement(activeTheme, index);
    
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
                              onPressed: () {},
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
