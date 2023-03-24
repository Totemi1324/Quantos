import '../../models/content/interactive.dart';

import 'empty_interactive.dart';

class InteractiveLookup {
  static Interactive getElement(String id, String caption, String altText,
      {Map<String, dynamic>? args}) {
    switch (id) {
      default:
        return EmptyInteractive(caption: caption, altText: altText);
    }
  }
}
