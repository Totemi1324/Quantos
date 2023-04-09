import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'content_parser.dart';

import '../models/content/lesson_content.dart';
import '../models/content/paragraph.dart';
import '../models/exceptions.dart';

class LessonContentService extends Cubit<LessonContent> {
  static const paragraphJsonKey = "paragraph";
  static const sectionTitleJsonKey = "sectiontitle";
  static const imageJsonKey = "image";
  static const equationJsonKey = "equation";
  static const interactiveJsonKey = "interactive";
  static const pageBreakJsonKey = "pagebreak";

  LessonContentService() : super(LessonContent.empty());

  Locale? previousLocale;

  Future loadByIdFromLocale(
      String lessonId, Locale locale, AppLocalizations localizations) async {
    if (lessonId == state.lessonId &&
        previousLocale != null &&
        previousLocale == locale) {
      return;
    }

    state.lessonId = lessonId;
    previousLocale = locale;

    try {
      final jsonString = await rootBundle
          .loadString("lessons/${locale.languageCode}/lesson-$lessonId.json");

      state.clearContentData();
      _parse(jsonString);
    } on ParseErrorException catch (exception) {
      state.clearContentData();
      state.addContentItem(Paragraph(
        texts: [
          ParagraphSpan(
            type: ParagraphSpanType.normal,
            text: localizations.parsingErrorParagraph(exception.message),
          ),
        ],
      ));
      state.breakPage();
    } catch (exception) {
      state.clearContentData();
      state.addContentItem(Paragraph(
        texts: [
          ParagraphSpan(
            type: ParagraphSpanType.normal,
            text: localizations.unknownErrorParagraph(exception.toString()),
          ),
        ],
      ));
      state.breakPage();
    }

    emit(state);
  }

  void _parse(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.value is! Map<String, dynamic>) {
        state.breakPage();
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
          state.breakPage();
          break;
      }
    }

    state.breakPage();
  }
}
