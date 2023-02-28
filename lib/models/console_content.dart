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
  final String? formatted;

  const ConsoleContent(this.status, {this.record, this.formatted});

  factory ConsoleContent.initial() => const ConsoleContent(ConsoleStatus.idle);
}
