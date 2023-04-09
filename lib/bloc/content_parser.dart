import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';
import '../models/content/interactive.dart';
import '../models/download.dart';
import '../models/download_category.dart';
import '../models/platform.dart';
import '../models/exceptions.dart';

import '../widgets/interactives/interactive_lookup.dart';

class ContentParser {
  static const textJsonKey = "text";
  static const titleJsonKey = "title";
  static const assetJsonKey = "asset";
  static const captionJsonKey = "caption";
  static const altTextJsonKey = "alttext";
  static const texJsonKey = "tex";
  static const idJsonKey = "id";
  static const argsJsonKey = "args";

  static const categoryJsonKey = "category";
  static const downloadSizeJsonKey = "downloadsize";
  static const sizeJsonKey = "size";
  static const unitJsonKey = "unit";
  static const typeJsonKey = "type";
  static const linksJsonKey = "links";
  static const availabilityJsonKey = "availability";
  static const descriptionJsonKey = "description";

  static const formatters = {
    ParagraphSpanType.bold: r"**",
    ParagraphSpanType.equation: r"$$",
  };

  static Paragraph parseParagraph(Map<String, dynamic> json) {
    if (!json.containsKey(textJsonKey)) {
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
    if (!json.containsKey(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }

    final title = json[titleJsonKey] as String;

    return SectionTitle(title: title);
  }

  static Image parseImage(Map<String, dynamic> json) {
    if (!json.containsKey(assetJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: assetJsonKey,
      );
    }
    if (!json.containsKey(captionJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: captionJsonKey,
      );
    }
    if (!json.containsKey(altTextJsonKey)) {
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
    if (!json.containsKey(texJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: texJsonKey,
      );
    }
    if (!json.containsKey(altTextJsonKey)) {
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
    if (!json.containsKey(idJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: idJsonKey,
      );
    }
    if (!json.containsKey(captionJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: captionJsonKey,
      );
    }
    if (!json.containsKey(altTextJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: altTextJsonKey,
      );
    }
    if (!json.containsKey(argsJsonKey)) {
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

  static DownloadCategory parseDownloadCategory(
      String id, Map<String, dynamic> json) {
    if (!json.containsKey(availabilityJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: availabilityJsonKey,
      );
    }

    final availabilityList = json[availabilityJsonKey] as List<dynamic>;
    final availability = availabilityList
        .map(
          (e) => (e as num).round(),
        )
        .map(
          (e) => e < Platform.values.length
              ? Platform.values[e]
              : Platform.undefined,
        );

    return DownloadCategory(id, title: "", availableOn: availability.toSet());
  }

  static DownloadCategory updateDownloadCategoryLocalization(
          DownloadCategory previous, String value) =>
      DownloadCategory(previous.id,
          title: value, availableOn: previous.availableOn);

  static Download parseDownload(String id, Map<String, dynamic> json) {
    if (!json.containsKey(categoryJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: categoryJsonKey,
      );
    }
    if (!json.containsKey(downloadSizeJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: downloadSizeJsonKey,
      );
    }
    if (!json.containsKey(typeJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: typeJsonKey,
      );
    }
    if (!json.containsKey(linksJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: linksJsonKey,
      );
    }
    if (!json.containsKey(availabilityJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: availabilityJsonKey,
      );
    }

    final category = json[categoryJsonKey] as String;
    final downloadSizeJson = json[downloadSizeJsonKey] as Map<String, dynamic>;
    final type = (json[typeJsonKey] as num).toDouble();
    final linksMap = json[linksJsonKey] as Map<String, dynamic>;
    final availabilityList = json[availabilityJsonKey] as List<dynamic>;

    final downloadSize = _parseDownloadSize(downloadSizeJson);
    final availability = availabilityList
        .map(
          (e) => (e as num).round(),
        )
        .map(
          (e) => e < Platform.values.length
              ? Platform.values[e]
              : Platform.undefined,
        );
    final links = Map<String, String>.fromEntries(linksMap.entries
        .map((entry) => MapEntry(entry.key, entry.value as String)));

    return Download(id,
        title: "",
        description: "",
        categoryId: category,
        size: downloadSize,
        type: FileType.values[type.round()],
        links: links,
        availableOn: availability.toSet());
  }

  static Download updateDownloadLocalization(
      Download previous, Map<String, dynamic> json) {
    if (!json.containsKey(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }
    if (!json.containsKey(descriptionJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: descriptionJsonKey,
      );
    }

    final title = json[titleJsonKey] as String;
    final description = json[descriptionJsonKey] as String;

    return Download(previous.id,
        title: title,
        description: description,
        categoryId: previous.categoryId,
        size: previous.size,
        type: previous.type,
        links: previous.links,
        availableOn: previous.availableOn);
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

  static DownloadSize _parseDownloadSize(Map<String, dynamic> json) {
    if (!json.containsKey(sizeJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: sizeJsonKey,
      );
    }
    if (!json.containsKey(unitJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: unitJsonKey,
      );
    }

    final size = json[sizeJsonKey] as num;
    final unit = json[unitJsonKey] as num;

    return DownloadSize(
      size: size.toDouble(),
      unit: DownloadSizeUnit.values[unit.round()],
    );
  }
}
