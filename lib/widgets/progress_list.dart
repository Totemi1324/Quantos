import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_service.dart';
import '../bloc/content_outline_service.dart';
import '../bloc/database_service.dart';

import '../models/content/content_outline.dart';
import './ui/adaptive_progress_bar.dart';

class ProgressList extends StatefulWidget {
  const ProgressList({super.key});

  @override
  State<ProgressList> createState() => _ProgressListState();
}

class _ProgressListState extends State<ProgressList> {
  @override
  Widget build(BuildContext context) {
    final lections = context.read<ContentOutlineService>().lections;

    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeService, ThemeData>(
          listener: (context, state) => setState(() {}),
        ),
        BlocListener<ContentOutlineService, ContentOutline>(
          listener: (context, state) => setState(() {}),
        ),
      ],
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lections.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context
                    .read<ContentOutlineService>()
                    .state
                    .getLectionTitle(lections[index].id),
                style: context.read<ThemeService>().state.textTheme.titleMedium,
              ),
              AdaptiveProgressBar.text(
                context
                    .read<DatabaseService>()
                    .lectionProgress(lections[index].id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
