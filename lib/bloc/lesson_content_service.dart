import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale, SizedBox;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/content/lesson_content.dart';
import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';
import '../models/content/interactive.dart';
import '../models/exceptions.dart';

class LessonContentService extends Cubit<LessonContent> {
  static const paragraphJsonKey = "paragraph";
  static const sectionTitleJsonKey = "sectiontitle";
  static const imageJsonKey = "image";
  static const equationJsonKey = "equation";
  static const interactiveJsonKey = "interactive";

  static const textJsonKey = "text";
  static const titleJsonKey = "title";
  static const assetJsonKey = "asset";
  static const captionJsonKey = "caption";
  static const altTextJsonKey = "alttext";
  static const texJsonKey = "tex";

  static const formatters = {
    ParagraphSpanType.bold: r"**",
    ParagraphSpanType.equation: r"$$",
  };

  LessonContentService() : super(LessonContent.empty());

  Future loadByIdFromLocale(
      String lessonId, Locale locale, AppLocalizations localizations) async {
    if (lessonId == state.lessonId) {
      return;
    }

    state.lessonId = lessonId;

    try {
      final jsonString = await rootBundle
          .loadString("lessons/${locale.languageCode}/lesso-$lessonId.json");

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
    }

    emit(state);
  }

  void _parse(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.value is! Map<String, dynamic>) {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }

      final content = entry.value as Map<String, dynamic>;

      switch (entry.key.substring(0, entry.key.indexOf("-"))) {
        case paragraphJsonKey:
          state.content.add(_parseParagraph(content));
          break;
        case sectionTitleJsonKey:
          state.content.add(_parseSectionTitle(content));
          break;
        case imageJsonKey:
          state.content.add(_parseImage(content));
          break;
        case equationJsonKey:
          state.content.add(_parseEquation(content));
          break;
        case interactiveJsonKey:
          state.content.add(_parseInteractive(content));
          break;
      }
    }
  }

  Paragraph _parseParagraph(Map<String, dynamic> json) {
    if (!json.keys.contains(textJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: textJsonKey,
      );
    }

    final text = json[textJsonKey] as String;
    final spans = _extractSpans(text);

    return Paragraph(texts: spans);
  }

  SectionTitle _parseSectionTitle(Map<String, dynamic> json) {
    if (!json.keys.contains(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }

    final title = json[titleJsonKey] as String;

    return SectionTitle(title: title);
  }

  Image _parseImage(Map<String, dynamic> json) {
    if (!json.keys.contains(assetJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: assetJsonKey,
      );
    }
    if (!json.keys.contains(captionJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: captionJsonKey,
      );
    }
    if (!json.keys.contains(altTextJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: altTextJsonKey,
      );
    }

    final asset = json[assetJsonKey] as String;
    final caption = json[captionJsonKey] as String;
    final altText = json[altTextJsonKey] as String;

    return Image(asset: asset, caption: caption, altText: altText);
  }

  Equation _parseEquation(Map<String, dynamic> json) {
    if (!json.keys.contains(texJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: texJsonKey,
      );
    }
    if (!json.keys.contains(altTextJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: altTextJsonKey,
      );
    }

    final tex = json[texJsonKey] as String;
    final altText = json[altTextJsonKey] as String;

    return Equation(tex: tex, altText: altText);
  }

  Interactive _parseInteractive(Map<String, dynamic> json) {
    return const Interactive(
        content: SizedBox(height: 50), caption: "", altText: "");
  }

  static List<ParagraphSpan> _extractSpans(String text) {
    final List<ParagraphSpan> spans = [];

    final boldIndex = text.indexOf(RegExp(r"\*\*.*\*\*"));
    final equationIndex = text.indexOf(RegExp(r"\$\$.*\$\$"));

    if (boldIndex == -1 && equationIndex == -1) {
      spans.add(ParagraphSpan(type: ParagraphSpanType.normal, text: text));
      return spans;
    } else {
      if (equationIndex == -1) {
        spans.addAll(_extractType(text, ParagraphSpanType.bold, boldIndex));
        return spans;
      } else if (boldIndex == -1) {
        spans.addAll(
            _extractType(text, ParagraphSpanType.equation, equationIndex));
        return spans;
      } else {
        if (boldIndex < equationIndex) {
          spans.addAll(_extractType(text, ParagraphSpanType.bold, boldIndex));
          return spans;
        } else {
          spans.addAll(
              _extractType(text, ParagraphSpanType.equation, equationIndex));
          return spans;
        }
      }
    }
  }

  static List<ParagraphSpan> _extractType(
      String text, ParagraphSpanType type, int index) {
    final List<ParagraphSpan> spans = [];
    final endIndex = text.indexOf(formatters[type]!, index + 2);

    spans.addAll(_extractFormatted(text, index, endIndex, type));
    spans.addAll(_extractSpans(text.substring(endIndex + 2)));

    return spans;
  }

  static List<ParagraphSpan> _extractFormatted(
      String text, int beginIndex, int endIndex, ParagraphSpanType type) {
    final List<ParagraphSpan> spans = [];

    if (beginIndex != 0) {
      spans.add(
        ParagraphSpan(
          type: ParagraphSpanType.normal,
          text: text.substring(0, beginIndex),
        ),
      );
    }
    spans.add(
      ParagraphSpan(
        type: type,
        text: text.substring(
          beginIndex + 2,
          endIndex,
        ),
      ),
    );
    return spans;
  }
}
