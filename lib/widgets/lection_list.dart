import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/lesson_content_service.dart';
import '../bloc/lesson_content_service.dart';

import '../screens/lection_screen.dart';
import './containers/panel_card.dart';
import "./lection_item.dart";

class LectionList extends StatelessWidget {
  const LectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final lections = context.read<LessonContentService>().lections;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lections.length,
      itemBuilder: (buildContext, index) {
        final lection =
            context.read<LessonContentService>().lection(lections[index].id);

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: lections[index].unlocked
              ? () => Navigator.of(context).pushNamed(
                    LectionScreen.routeName,
                    arguments: lection.id,
                  )
              : null,
          child: PanelCard(
            padding: const EdgeInsets.all(10),
            child: LectionItem(
              context
                  .read<LessonContentService>()
                  .state
                  .getLectionTitle(lection.id),
              iconAnimationAsset: lection.iconAnimationAsset,
              progressPercent: lection.progressPercent,
              unlocked: lection.unlocked,
            ),
          ),
        );
      },
    );
  }
}
