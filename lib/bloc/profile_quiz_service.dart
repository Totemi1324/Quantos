import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';

import 'content_parser.dart';

import '../models/profile_quiz_content.dart';
import '../models/exceptions.dart';

class ProfileQuizService extends Cubit<ProfileQuizContent> {
  static const paragraphJsonKey = "paragraph";
  static const sectionTitleJsonKey = "sectiontitle";
  static const imageJsonKey = "image";
  static const equationJsonKey = "equation";
  static const interactiveJsonKey = "interactive";
  static const pageBreakJsonKey = "pagebreak";

  ProfileQuizService() : super(ProfileQuizContent.empty());

  Future loadFromLocale(Locale locale) async {
    try {
      final assetName = "quiz/${locale.languageCode}.json";
      final jsonString = await rootBundle.loadString(assetName);

      state.clearData();
      _parse(jsonString);
    } catch (exception) {
      state.clearData();
      throw ProcessFailedException(exception as Exception);
    }

    emit(state);
  }

  int previousQuestion() {
    final current = state.currentQuestion;
    emit(
      ProfileQuizContent(
        questions: state.questions.toList(),
        currentQuestion: current - 1,
      ),
    );
    return current - 1;
  }

  int nextQuestion() {
    final current = state.currentQuestion;
    emit(
      ProfileQuizContent(
        questions: state.questions.toList(),
        currentQuestion: current + 1,
      ),
    );
    return current + 1;
  }

  void _parse(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.value is! Map<String, dynamic>) {
        state.finalizeQuestion();
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }

      final content = entry.value as Map<String, dynamic>;

      switch (entry.key.substring(0, entry.key.indexOf("-"))) {
        case paragraphJsonKey:
          state.addContentItem(ContentParser.parseParagraph(content));
          break;
        case sectionTitleJsonKey:
          state.addContentItem(ContentParser.parseSectionTitle(content));
          break;
        case imageJsonKey:
          state.addContentItem(ContentParser.parseImage(content));
          break;
        case equationJsonKey:
          state.addContentItem(ContentParser.parseEquation(content));
          break;
        case interactiveJsonKey:
          state.addContentItem(ContentParser.parseInteractive(content));
          break;
        case pageBreakJsonKey:
          state.finalizeQuestion();
          break;
      }
    }

    state.finalizeQuestion();
  }
}
