import 'package:flutter/material.dart' hide Image;

import '../models/lection.dart';
import '../models/lesson.dart';

import '../models/content/content_item.dart';
import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';
import '../models/content/interactive.dart';

class LessonContentParser {
  static const formatters = {
    ParagraphSpanType.bold: "**",
    ParagraphSpanType.equation: r"$$",
  };

  static bool parseFromJson(Map<String, dynamic> json, List<Lection> lections) {
    for (var entry in json.entries) {
      if (entry.key.substring(0, 8) != "lection-") return false;
      final lectionId = entry.key.substring(8);
      final lection = lections.firstWhere((lection) => lection.id == lectionId);

      if (entry.value is! Map<String, dynamic> ||
          !_parseLection(entry.value as Map<String, dynamic>, lection)) {
        return false;
      }
    }

    return true;
  }

  static bool _parseLection(Map<String, dynamic> json, Lection lection) {
    lection.title = json["title"];
    lection.description = json["description"];

    if (json["content"] is! Map<String, dynamic>) return false;
    final content = json["content"] as Map<String, dynamic>;

    for (var entry in content.entries) {
      if (entry.key.substring(0, 7) != "lesson-") return false;
      final lessonId = entry.key.substring(7);
      final lesson =
          lection.lessons.firstWhere((lesson) => lesson.id == lessonId);

      if (entry.value is! Map<String, dynamic> ||
          !_parseLesson(entry.value as Map<String, dynamic>, lesson)) {
        return false;
      }
    }

    return true;
  }

  static bool _parseLesson(Map<String, dynamic> json, Lesson lesson) {
    lesson.title = json["title"];

    if (json["content"] is! Map<String, dynamic>) return false;
    final content = json["content"] as Map<String, dynamic>;

    lesson.content.clear();

    for (var entry in content.entries) {
      if (entry.value is! Map<String, dynamic>) return false;
      final content = entry.value as Map<String, dynamic>;
      ContentItem? item;

      switch (entry.key.substring(0, entry.key.indexOf("-"))) {
        case "paragraph":
          item = _parseParagraph(content);
          break;
        case "sectiontitle":
          item = _parseSectionTitle(content);
          break;
        case "image":
          item = _parseImage(content);
          break;
        case "equation":
          item = _parseEquation(content);
          break;
        case "interactive":
          item = _parseInteractive(content);
          break;
      }

      if (item == null) return false;
      lesson.content.add(item);
    }

    return true;
  }

  static Paragraph? _parseParagraph(Map<String, dynamic> json) {
    final text = json["text"] as String?;
    if (text == null) {
      return null;
    }

    final spans = extractSpans(text);

    if (spans.isEmpty) {
      return null;
    }

    return Paragraph(texts: spans);
  }

  static List<ParagraphSpan> extractSpans(String text) {
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
    final endIndex = text.indexOf(formatters[type] ?? "", index + 2);

    spans.addAll(_extractFormatted(text, index, endIndex, type));
    spans.addAll(extractSpans(text.substring(endIndex + 2)));

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

  static SectionTitle? _parseSectionTitle(Map<String, dynamic> json) {
    final title = json["title"] as String?;
    if (title == null) {
      return null;
    }

    return SectionTitle(title: title);
  }

  static Image? _parseImage(Map<String, dynamic> json) {
    final asset = json["asset"] as String?;
    final caption = json["caption"] as String?;
    final altText = json["alttext"] as String?;

    if (asset == null || caption == null || altText == null) {
      return null;
    }

    return Image(asset: asset, caption: caption, altText: altText);
  }

  static Equation? _parseEquation(Map<String, dynamic> json) {
    final tex = json["tex"] as String?;
    final altText = json["alttext"] as String?;

    if (tex == null || altText == null) {
      return null;
    }

    return Equation(tex: tex, altText: altText);
  }

  static Interactive? _parseInteractive(Map<String, dynamic> json) {
    return const Interactive(
        content: SizedBox(height: 50), caption: "", altText: "");
  }
}
