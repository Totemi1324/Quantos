import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../bloc/profile_quiz_service.dart';

import './forms/quiz_form.dart';
import '../models/navigation_action.dart';
import '../models/content/content_item.dart';
import '../models/content/paragraph.dart';
import '../models/content/equation.dart';

class QuizRenderer extends StatefulWidget {
  final Stream<Tuple2<BuildContext, NavigationAction>> navigationStream;

  const QuizRenderer({required this.navigationStream, super.key});

  @override
  State<QuizRenderer> createState() => _QuizRendererState();
}

class _QuizRendererState extends State<QuizRenderer> {
  final _formController = StreamController<Tuple2<BuildContext, int>>();

  @override
  void initState() {
    super.initState();

    widget.navigationStream.listen(
      (event) /*async*/ {
        if (!_checkValidNavigation(event.item1, event.item2)) {
          return;
        }
        //await _fadeController.reverse();
        _navigate(event.item1, event.item2);
        //_scrollController.jumpTo(0);
        //_fadeController.forward();
      },
    );
  }

  bool _checkValidNavigation(
      BuildContext buildContext, NavigationAction action) {
    final currentState = buildContext.read<ProfileQuizService>().state;
    switch (action) {
      case NavigationAction.next:
        return currentState.moveNextIsSafe;
      case NavigationAction.previous:
        return currentState.movePreviousIsSafe;
      default:
        return false;
    }
  }

  void _navigate(BuildContext buildContext, NavigationAction action) {
    final service = buildContext.read<ProfileQuizService>();
    switch (action) {
      case NavigationAction.next:
        setState(() {
          final newQuestion = service.nextQuestion();
          _formController.add(
            Tuple2(
              buildContext,
              newQuestion,
            ),
          );
        });
        break;
      case NavigationAction.previous:
        setState(() {
          final newQuestion = service.previousQuestion();
          _formController.add(
            Tuple2(
              buildContext,
              newQuestion,
            ),
          );
        });
        break;
      default:
        break;
    }
  }

  Widget _buildContentItem(BuildContext buildContext, ContentItem item) {
    switch (item.type) {
      case ContentType.paragraph:
        final paragraph = item as Paragraph;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: Theme.of(buildContext).textTheme.bodyMedium,
              children: _transformParagraphSpans(
                paragraph.texts,
                Theme.of(buildContext)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      case ContentType.equation:
        final equation = item as Equation;
        final longTex = Math.tex(
          equation.tex,
          mathStyle: MathStyle.display,
          textStyle:
              TextStyle(color: Theme.of(buildContext).colorScheme.onBackground),
        );
        return Container(
          margin: const EdgeInsets.only(top: 15, bottom: 25),
          child: Tooltip(
            message: equation.altText,
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: longTex.texBreak().parts,
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  List<InlineSpan> _transformParagraphSpans(
      List<ParagraphSpan> spans, TextStyle? boldStyle) {
    final List<InlineSpan> result = [];

    for (var span in spans) {
      switch (span.type) {
        case ParagraphSpanType.normal:
          result.add(TextSpan(text: span.text));
          break;
        case ParagraphSpanType.bold:
          result.add(TextSpan(text: span.text, style: boldStyle));
          break;
        case ParagraphSpanType.equation:
          result.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                span.text,
                mathStyle: MathStyle.text,
              ),
            ),
          );
          break;
      }
    }

    return result;
  }

  List<Widget> _buildQuestion(BuildContext buildContext, int questionIndex) {
    final List<Widget> question = buildContext
        .read<ProfileQuizService>()
        .state
        .questions[questionIndex]
        .map((item) => _buildContentItem(buildContext, item))
        .toList();

    return question;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex =
        context.read<ProfileQuizService>().state.currentQuestion;

    return Column(
      children: [
        ..._buildQuestion(
          context,
          currentQuestionIndex,
        ),
        const SizedBox(
          height: 30,
        ),
        QuizForm(
          formStream: _formController.stream,
        ),
      ],
    );
  }
}
