class UserCredentials {
  final String userId;
  final String token;
  final DateTime? expiryDate;

  const UserCredentials({
    required this.userId,
    required this.token,
    required this.expiryDate,
  });

  factory UserCredentials.empty() => const UserCredentials(
        userId: "",
        token: "",
        expiryDate: null,
      );
}
