import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/user_credentials.dart';
import '../models/exceptions.dart';
import '../credentials.dart';

class AuthenticationService extends Cubit<UserCredentials> {
  static AuthenticationError _firebaseErrorCodes(String errorCode) {
    switch (errorCode) {
      case "EMAIL_EXISTS":
        return AuthenticationError.emailExists;
      case "TOO_MANY_ATTEMPTS_TRY_LATER":
        return AuthenticationError.tooManyAttempts;
      case "EMAIL_NOT_FOUND":
        return AuthenticationError.emailNotFound;
      case "INVALID_PASSWORD":
        return AuthenticationError.invalidPassword;
      case "USER_DISABLED":
        return AuthenticationError.userDisabled;
      default:
        return AuthenticationError.unknown;
    }
  }

  AuthenticationService() : super(UserCredentials.empty());

  Future attemptSignUp(String email, String password) async {
    return _sendAuthRequest(email, password, "signUp");
  }

  Future attemptLogIn(String email, String password) async {
    return _sendAuthRequest(email, password, "signInWithPassword");
  }

  Future _sendAuthRequest(
      String email, String password, String firebaseOperationSegment) async {
    final credentials = await CredentialsLoader.load();

    final endpoint = Uri.https(
      "identitytoolkit.googleapis.com",
      "/v1/accounts:$firebaseOperationSegment",
      {"key": credentials.firebaseApiKey},
    );

    try {
      final response = await http.post(
        endpoint,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final responseJson = json.decode(response.body) as Map<String, dynamic>;
      if (responseJson["error"] != null && responseJson["error"]["message"] is String) {
        throw AuthenticationException(_firebaseErrorCodes(responseJson["error"]["message"]));
      }
    } catch (error) {
      rethrow;
    }
  }
}
