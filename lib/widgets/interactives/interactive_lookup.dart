import '../../models/content/interactive.dart';

import 'empty_interactive.dart';
import 'n_queens_success_rate_advantage.dart';
import 'n_queens_success_rate_2000q.dart';

class InteractiveLookup {
  static Interactive getElement(String id, String caption, String altText,
      {Map<String, dynamic>? args}) {
    switch (id) {
      case NQueensSuccessRateAdvantage.identifier:
        return NQueensSuccessRateAdvantage(
            caption: caption, altText: altText, args: args);
      case NQueensSuccessRate2000Q.identifier:
        return NQueensSuccessRate2000Q(
            caption: caption, altText: altText, args: args);
      default:
        return EmptyInteractive(caption: caption, altText: altText);
    }
  }
}
