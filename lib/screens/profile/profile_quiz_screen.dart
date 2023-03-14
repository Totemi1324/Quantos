import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantos/bloc/database_service.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:tuple/tuple.dart';

import '../../bloc/profile_quiz_service.dart';

import '../base/flat.dart';
import '../../models/navigation_action.dart';
import '../../models/profile_quiz_content.dart';
import '../../widgets/quiz_renderer.dart';
import '../../widgets/ui/adaptive_button.dart';
import './profile_experience_screen.dart';

class ProfileQuizScreen extends StatefulWidget {
  static const routeName = "profile/quiz";

  const ProfileQuizScreen({super.key});

  @override
  State<ProfileQuizScreen> createState() => _ProfileQuizScreenState();
}

class _ProfileQuizScreenState extends State<ProfileQuizScreen> {
  final _navigationController =
      StreamController<Tuple2<BuildContext, NavigationAction>>();

  SMINumber? _currentQuestion;
  SMITrigger? _select;
  SMITrigger? _back;
  SMITrigger? _finish;

  void _onInit(Artboard artboard) {
    var controller = StateMachineController.fromArtboard(artboard, "QuizStates")
        as StateMachineController;
    artboard.addController(controller);
    _currentQuestion =
        controller.findInput<double>("currentQuestion") as SMINumber;
    _select = controller.findInput<bool>("select") as SMITrigger;
    _back = controller.findInput<bool>("back") as SMITrigger;
    _finish = controller.findInput<bool>("finish") as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex =
        context.read<ProfileQuizService>().state.currentQuestion;
    final numberOfQuestions =
        context.read<ProfileQuizService>().state.numberOfQuestions;

    return BlocListener<ProfileQuizService, ProfileQuizContent>(
      listener: (context, state) {
        if (_currentQuestion != null) {
          _currentQuestion!.value = state.currentQuestion + 1;
        }
        if (state.currentQuestion < currentQuestionIndex) {
          if (context
                  .read<DatabaseService>()
                  .answerForQuestion(state.currentQuestion + 1) !=
              null) {
            _back?.fire();
          }
        }
        if (state.currentQuestion > currentQuestionIndex) {
          if (context
                  .read<DatabaseService>()
                  .answerForQuestion(state.currentQuestion) !=
              null) {
            _select?.fire();
          }
        }
        setState(() {});
      },
      child: Flat(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0.9, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: SingleChildScrollView(
                      child: QuizRenderer(
                        navigationStream: _navigationController.stream,
                        onSelect: () {
                          _select?.fire();
                        },
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: RiveAnimation.asset(
                    Assets.animations.assessmentQuiz,
                    fit: BoxFit.contain,
                    onInit: _onInit,
                  ),
                ),
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
                      if (currentQuestionIndex == numberOfQuestions - 1)
                        AdaptiveButton.primary(
                          AppLocalizations.of(context)!.continueButtonLabel,
                          extended: false,
                          enabled: true,
                          onPressed: () {
                            _finish?.fire(); //TODO: Exit if already pressed
                            Future.delayed(
                              const Duration(milliseconds: 1700),
                              () => Navigator.of(context)
                                  .pushNamed(ProfileExperienceScreen.routeName),
                            );
                          },
                        ),
                      if (currentQuestionIndex != numberOfQuestions - 1)
                        AdaptiveButton.navigator(
                          type: ButtonType.secondary,
                          tooltip:
                              AppLocalizations.of(context)!.tooltipNextPage,
                          onPressed: () {
                            _navigationController.add(
                              Tuple2(context, NavigationAction.next),
                            );
                          },
                          icon: Icons.navigate_next_rounded,
                        ),
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
