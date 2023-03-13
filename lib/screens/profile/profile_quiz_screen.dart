import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../bloc/profile_quiz_service.dart';

import '../base/flat.dart';
import '../../models/navigation_action.dart';
import '../../models/profile_quiz_content.dart';
import '../../widgets/quiz_renderer.dart';
import '../../widgets/ui/adaptive_button.dart';

class ProfileQuizScreen extends StatefulWidget {
  static const routeName = "profile/quiz";

  const ProfileQuizScreen({super.key});

  @override
  State<ProfileQuizScreen> createState() => _ProfileQuizScreenState();
}

class _ProfileQuizScreenState extends State<ProfileQuizScreen> {
  final _navigationController =
      StreamController<Tuple2<BuildContext, NavigationAction>>();

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex =
        context.read<ProfileQuizService>().state.currentQuestion;
    final numberOfQuestions =
        context.read<ProfileQuizService>().state.numberOfQuestions;

    return BlocListener<ProfileQuizService, ProfileQuizContent>(
      listener: (context, state) => setState(() {}),
      child: Flat(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuizRenderer(navigationStream: _navigationController.stream),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentQuestionIndex != 0
                          ? AdaptiveButton.navigator(
                              type: ButtonType.secondary,
                              tooltip: AppLocalizations.of(context)!
                                  .tooltipPreviousPage,
                              onPressed: () {
                                _navigationController.add(
                                  Tuple2(context, NavigationAction.previous),
                                );
                              },
                              icon: Icons.navigate_before_rounded,
                            )
                          : Container(),
                      currentQuestionIndex != numberOfQuestions - 1
                          ? AdaptiveButton.navigator(
                              type: ButtonType.secondary,
                              tooltip:
                                  AppLocalizations.of(context)!.tooltipNextPage,
                              onPressed: () {
                                _navigationController.add(
                                  Tuple2(context, NavigationAction.next),
                                );
                              },
                              icon: Icons.navigate_next_rounded,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
