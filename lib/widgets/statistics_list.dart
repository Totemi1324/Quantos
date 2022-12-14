import 'package:flutter/material.dart';

import '../models/titled_element.dart';
import './containers/rounded_card.dart';
import './canvas/line_chart.dart';
import './canvas/heatmap_chart.dart';
import './progress_list.dart';

class StatisticsList extends StatelessWidget {
  final int elementCount = 3;

  const StatisticsList({super.key});

  TitledElement _buildElement(BuildContext buildContext, int index) {
    switch (index) {
      case 0:
        return TitledElement(
          title: "Activity",
          element: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "this month",
                style: Theme.of(buildContext).textTheme.labelSmall,
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
                          color: Theme.of(buildContext).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "online",
                    style: Theme.of(buildContext).textTheme.labelSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(buildContext).colorScheme.secondary,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "offline",
                    style: Theme.of(buildContext).textTheme.labelSmall,
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
                style: Theme.of(buildContext).textTheme.labelSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              const LineChart(),
              Text(
                "completed lessons per day",
                style: Theme.of(buildContext).textTheme.labelSmall,
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: elementCount,
      itemBuilder: (context, index) {
        TitledElement item = _buildElement(context, index);

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
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    if (index != 2)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.record_voice_over_rounded,
                              color: Colors.white,
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
    );
  }
}
