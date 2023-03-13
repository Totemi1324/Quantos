import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:tuple/tuple.dart';

import '../../bloc/profile_quiz_service.dart';
import '../../bloc/database_service.dart';

import '../../models/user_data.dart';

class QuizForm extends StatefulWidget {
  final Stream<Tuple2<BuildContext, int>> formStream;

  const QuizForm({required this.formStream, super.key});

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
          BuildContext buildContext, int questionIndex) =>
      _currentAnswer =
          buildContext.read<DatabaseService>().answerForQuestion(questionIndex);

  Widget _titleForAnswer(BuildContext buildContext, int answerIndex) {
    String title = "";

    switch (answerIndex) {
      case 0:
        title = AppLocalizations.of(buildContext)!.profileQuizAnswer1;
        break;
      case 1:
        title = AppLocalizations.of(buildContext)!.profileQuizAnswer2;
        break;
      case 2:
        title = AppLocalizations.of(buildContext)!.profileQuizAnswer3;
        break;
      default:
        break;
    }

    return Text(
      title,
      style: Theme.of(buildContext).textTheme.labelMedium,
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
          setState(() {
            _currentAnswer = value;
          });
          context.read<DatabaseService>().setAnswerToQuestion(
                context.read<ProfileQuizService>().state.currentQuestion,
                value,
              );
        },
      ),
    );
  }
}
