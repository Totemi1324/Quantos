import 'package:qubo_embedder/qubo_embedder.dart' show SolutionRecord;

enum ConsoleStatus {
  idle,
  loading,
  success,
  failure,
}

class ConsoleContent {
  final ConsoleStatus status;
  final SolutionRecord? record;

  const ConsoleContent(this.status, {this.record});

  factory ConsoleContent.initial() => const ConsoleContent(ConsoleStatus.idle);
}
