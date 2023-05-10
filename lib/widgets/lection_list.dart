import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:universal_platform/universal_platform.dart';

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

Widget _buildLectionItem(BuildContext buildContext, String lectionId) {
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    onTap: buildContext.read<DatabaseService>().isUnlocked(lectionId)
        ? () => Navigator.of(buildContext).pushNamed(
              LectionScreen.routeName,
              arguments: lectionId,
            )
        : null,
    child: PanelCard(
      padding: const EdgeInsets.all(10),
      child: LectionItem(
        buildContext
            .read<ContentOutlineService>()
            .state
            .getLectionTitle(lectionId),
        iconAnimation: buildContext
            .read<ContentOutlineService>()
            .lection(lectionId)
            .iconAnimation,
        progressPercent:
            buildContext.read<DatabaseService>().lectionProgress(lectionId),
        unlocked: buildContext.read<DatabaseService>().isUnlocked(lectionId),
      ),
    ),
  );
}

class _LectionListState extends State<LectionList> {
  String? prevLectionTitle;

  @override
  Widget build(BuildContext context) {
    final lections = context.read<ContentOutlineService>().lections;

    return MultiBlocListener(
      listeners: [
        BlocListener<ContentOutlineService, ContentOutline>(
          listener: (context, state) {
            var firstLectionTitle = state.getLectionTitle(lections[0].id);
            if (firstLectionTitle.isNotEmpty &&
                (prevLectionTitle == null ||
                    prevLectionTitle != firstLectionTitle)) {
              setState(() {});
            }
          },
        ),
        BlocListener<DatabaseService, UserData>(
          listener: (context, state) => setState(() {}),
        )
      ],
      child: StaggeredGrid.count(
        crossAxisCount: UniversalPlatform.isWeb ? 2 : 1,
        children: lections.map<Widget>((lection) {
          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: _buildLectionItem(context, lection.id),
          );
        }).toList(),
      ),
    );
  }
}
