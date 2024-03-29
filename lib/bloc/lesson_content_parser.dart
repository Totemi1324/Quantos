import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';
import '../models/content/interactive.dart';
import '../models/exceptions.dart';

import '../widgets/interactives/interactive_lookup.dart';

class LessonContentParser {
  static const paragraphJsonKey = "paragraph";
  static const sectionTitleJsonKey = "sectiontitle";
  static const imageJsonKey = "image";
  static const equationJsonKey = "equation";
  static const interactiveJsonKey = "interactive";
  static const pageBreakJsonKey = "pagebreak";

  static const textJsonKey = "text";
  static const titleJsonKey = "title";
  static const assetJsonKey = "asset";
  static const captionJsonKey = "caption";
  static const altTextJsonKey = "alttext";
  static const texJsonKey = "tex";
  static const idJsonKey = "id";
  static const argsJsonKey = "args";

  static const formatters = {
    ParagraphSpanType.bold: r"**",
    ParagraphSpanType.equation: r"$$",
  };

  static Paragraph parseParagraph(Map<String, dynamic> json) {
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

  static SectionTitle parseSectionTitle(Map<String, dynamic> json) {
    if (!json.keys.contains(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }

    final title = json[titleJsonKey] as String;

    return SectionTitle(title: title);
  }

  static Image parseImage(Map<String, dynamic> json) {
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

  static Equation parseEquation(Map<String, dynamic> json) {
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

  static Interactive parseInteractive(Map<String, dynamic> json) {
    if (!json.keys.contains(idJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: idJsonKey,
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
    if (!json.keys.contains(argsJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: argsJsonKey,
      );
    }

    final id = json[idJsonKey] as String;
    final caption = json[captionJsonKey] as String;
    final altText = json[altTextJsonKey] as String;
    final args = json[argsJsonKey] as Map<String, dynamic>;

    if (args.isEmpty) {
      return InteractiveLookup.getElement(id, caption, altText);
    } else {
      return InteractiveLookup.getElement(id, caption, altText, args: args);
    }
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
