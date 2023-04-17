class UserCredentials {
  final String userId;
  final String? userEmail;
  final DateTime? lastSignedIn;

  const UserCredentials({
    required this.userId,
    required this.userEmail,
    required this.lastSignedIn,
  });

  factory UserCredentials.empty() => const UserCredentials(
        userId: "",
        userEmail: "",
        lastSignedIn: null,
      );
}
