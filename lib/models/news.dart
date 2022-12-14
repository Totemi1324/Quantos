class News {
  final String senderIconNetworkAddress;
  final String message;
  final DateTime? date;

  News({
    required this.senderIconNetworkAddress,
    required this.message,
    this.date,
  });
}
