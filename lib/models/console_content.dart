enum ConsoleStatus {
  idle,
  loading,
  success,
  failure,
}

class ConsoleContent {
  final ConsoleStatus status;
  final String? message;

  const ConsoleContent(this.status, {this.message});

  factory ConsoleContent.initial() => const ConsoleContent(ConsoleStatus.idle);
}
