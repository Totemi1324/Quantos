import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';

import '../../bloc/profile_quiz_service.dart';
import '../../bloc/database_service.dart';

import '../../models/user_data.dart';

class QuizForm extends StatefulWidget {
  final Stream<Tuple2<BuildContext, int>> formStream;
  final VoidCallback onSelect;

  const QuizForm({required this.formStream, required this.onSelect, super.key});

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  QuizAnswer? _currentAnswer;

  @override
  void initState() {
    super.initState();

    widget.formStream.listen(
      (event) => _loadAnswerOfCurrentQuestion(event.item1, event.item2),
    );
  }

  void _loadAnswerOfCurrentQuestion(
      BuildContext buildContext, int questionIndex) {
    setState(() {
      _currentAnswer =
          buildContext.read<DatabaseService>().answerForQuestion(questionIndex);
    });
  }

  Widget _titleForAnswer(BuildContext buildContext, int answerIndex) {
    final localization = AppLocalizations.of(buildContext)!;
    String title = "";

    switch (answerIndex) {
      case 0:
        title = localization.profileQuizAnswer1;
        break;
      case 1:
        title = localization.profileQuizAnswer2;
        break;
      case 2:
        title = localization.profileQuizAnswer3;
        break;
      default:
        break;
    }

    return Text(
      title,
      style: Theme.of(buildContext).textTheme.labelMedium,
    );
  }

  void _onValueChange(BuildContext buildContext, QuizAnswer? newValue) {
    final currentQuestion =
        buildContext.read<ProfileQuizService>().state.currentQuestion;

    setState(() {
      _currentAnswer = newValue;
    });
    buildContext.read<DatabaseService>().setAnswerToQuestion(
          currentQuestion,
          newValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => RadioListTile<QuizAnswer>(
        activeColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.all(0),
        title: _titleForAnswer(context, index),
        groupValue: _currentAnswer,
        value: QuizAnswer.values[index],
        onChanged: (value) {
          _onValueChange(context, value);
          widget.onSelect();
        },
      ),
    );
  }
}
