import 'package:flutter/material.dart';

import '../bloc/lesson_manager.dart';
import '../screens/lection_screen.dart';
import './containers/panel_card.dart';
import "./lection_item.dart";

class LectionList extends StatelessWidget {
  const LectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final lections = LessonManager.of(context)?.lectionList() ?? [];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lections.length,
      itemBuilder: (buildContext, index) => InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: lections[index].unlocked
            ? () => Navigator.of(context).pushNamed(
                  LectionScreen.routeName,
                  arguments: lections[index].id,
                )
            : null,
        child: PanelCard(
          padding: const EdgeInsets.all(10),
          child: LectionItem(
            lections[index].title,
            iconAnimationAsset: lections[index].iconAnimationAsset,
            progressPercent: lections[index].progressPercent,
            unlocked: lections[index].unlocked,
          ),
        ),
      ),
    );
  }
}
