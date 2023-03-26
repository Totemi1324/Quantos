import '../../models/content/interactive.dart';

import './empty_interactive.dart';
import './n_queens_success_rate_advantage.dart';
import './n_queens_success_rate_2000q.dart';
import './chain_strength_success_rate.dart';
import './annealing_time_success_rate.dart';
import './n_queens_demo.dart';

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
      case ChainStrengthSuccessRate.identifier:
        return ChainStrengthSuccessRate(
            caption: caption, altText: altText, args: args);
      case AnnealingTimeSuccessRate.identifier:
        return AnnealingTimeSuccessRate(
            caption: caption, altText: altText, args: args);
      case NQueensDemo.identifier:
        return NQueensDemo(caption: caption, altText: altText);
      default:
        return EmptyInteractive(caption: caption, altText: altText);
    }
  }
}
