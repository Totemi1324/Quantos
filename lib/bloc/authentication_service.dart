import 'dart:convert';
import 'dart:async';

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

  Timer? _logoutTimer;

  AuthenticationService() : super(UserCredentials.empty());

  bool get isAuthenticated =>
      state.token != "" &&
      state.expiryDate != null &&
      state.expiryDate!.isAfter(DateTime.now());

  Future attemptSignUp(String email, String password) async {
    final responseData = await _sendAuthRequest(email, password, "signUp");
    _setAutomaticLogoutTimer();
    emit(
      UserCredentials(
        userId: responseData["localId"],
        token: responseData["idToken"],
        expiryDate: DateTime.now().add(
          Duration(
            seconds: int.parse(responseData["expiresIn"]),
          ),
        ),
      ),
    );
  }

  Future attemptLogIn(String email, String password) async {
    final responseData = await _sendAuthRequest(email, password, "signInWithPassword");
    _setAutomaticLogoutTimer();
    emit(
      UserCredentials(
        userId: responseData["localId"],
        token: responseData["idToken"],
        expiryDate: DateTime.now().add(
          Duration(
            seconds: int.parse(responseData["expiresIn"]),
          ),
        ),
      ),
    );
  }

  void logOut() {
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
    }
    emit(UserCredentials.empty());
  }

  Future<Map<String, dynamic>> _sendAuthRequest(
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
      if (responseJson["error"] != null &&
          responseJson["error"]["message"] is String) {
        throw AuthenticationException(
            _firebaseErrorCodes(responseJson["error"]["message"]));
      }
      return responseJson;
    } catch (error) {
      rethrow;
    }
  }

  void _setAutomaticLogoutTimer() {
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
    }

    final timeToLogout = state.expiryDate?.difference(DateTime.now()).inSeconds;
    if (timeToLogout == null) {
      return;
    }

    _logoutTimer = Timer(Duration(seconds: timeToLogout), logOut);
  }
}
