import 'package:flutter/material.dart';

import '../models/titled_element.dart';
import './containers/rounded_card.dart';
import './canvas/line_chart.dart';

class StatisticsList extends StatelessWidget {
  final int elementCount = 3;

  const StatisticsList({super.key});

  TitledElement _buildElement(int index) {
    switch (index) {
      case 0:
        return TitledElement(
          title: "Activity",
          element: Container(),
        );
      case 1:
        return const TitledElement(
          title: "Performace",
          element: LineChart(),
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
        TitledElement item = _buildElement(index);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            children: [
              RoundedCard(
                fillWidth: true,
                fillHeight: false,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: item.element,
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
