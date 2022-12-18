import 'package:flutter/material.dart';

import '../models/titled_element.dart';
import './containers/rounded_card.dart';
import './canvas/line_chart.dart';
import './canvas/heatmap_chart.dart';

class StatisticsList extends StatelessWidget {
  final int elementCount = 3;

  const StatisticsList({super.key});

  TitledElement _buildElement(BuildContext buildContext, int index) {
    switch (index) {
      case 0:
        return const TitledElement(
          title: "Activity",
          element: HeatmapChart(),
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
        return TitledElement(
          title: "Progress",
          element: Container(),
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
