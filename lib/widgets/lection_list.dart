import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/database_service.dart';

import '../screens/lection_screen.dart';
import '../models/content/content_outline.dart';
import '../models/user_data.dart';
import './containers/panel_card.dart';
import "./lection_item.dart";

class LectionList extends StatefulWidget {
  const LectionList({super.key});

  @override
  State<LectionList> createState() => _LectionListState();
}

class _LectionListState extends State<LectionList> {
  @override
  Widget build(BuildContext context) {
    final lections = context.read<ContentOutlineService>().lections;

    return MultiBlocListener(
      listeners: [
        BlocListener<ContentOutlineService, ContentOutline>(
          listener: (context, state) => setState(() {}),
        ),
        BlocListener<DatabaseService, UserData>(
          listener: (context, state) => setState(() {}),
        )
      ],
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lections.length,
        itemBuilder: (buildContext, index) {
          final lectionId = lections[index].id;

          return InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: context.read<DatabaseService>().isUnlocked(lectionId)
                ? () => Navigator.of(context).pushNamed(
                      LectionScreen.routeName,
                      arguments: lectionId,
                    )
                : null,
            child: PanelCard(
              padding: const EdgeInsets.all(10),
              child: LectionItem(
                context
                    .read<ContentOutlineService>()
                    .state
                    .getLectionTitle(lectionId),
                iconAnimationAsset: context
                    .read<ContentOutlineService>()
                    .lection(lectionId)
                    .iconAnimationAsset,
                progressPercent:
                    context.read<DatabaseService>().lectionProgress(lectionId),
                unlocked: context.read<DatabaseService>().isUnlocked(lectionId),
              ),
            ),
          );
        },
      ),
    );
  }
}
