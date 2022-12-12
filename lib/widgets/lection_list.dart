import 'package:flutter/material.dart';

import '../data/lections.dart';

import './containers/panel_card.dart';
import "./lection_item.dart";

class LectionList extends StatelessWidget {
  const LectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lections.length,
      itemBuilder: (buildContext, index) => InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () {},
        child: PanelCard(
          padding: const EdgeInsets.all(10),
          child: LectionItem(
            lections[index].title,
            previewImageAsset: lections[index].previewImageAsset,
            progressPercent: lections[index].progressPercent,
            unlocked: lections[index].unlocked,
          ),
        ),
      ),
    );
  }
}
