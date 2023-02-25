import 'dart:convert';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_credentials.dart';
import '../models/exceptions.dart';
import '../credentials.dart';

class AuthenticationService extends Cubit<UserCredentials> {
  static const String preferencesEntryKey = "userCredentials";

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
    _setAutomaticLogoutTimer();
    await _storeToken();
  }

  Future attemptLogIn(String email, String password) async {
    final responseData =
        await _sendAuthRequest(email, password, "signInWithPassword");
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
    _setAutomaticLogoutTimer();
    await _storeToken();
  }

  Future<bool> attemptAutoLogIn() async {
    final preferencesInstance = await SharedPreferences.getInstance();
    if (!preferencesInstance.containsKey(preferencesEntryKey)) {
      return false;
    }

    final userCredentials = preferencesInstance.getString(preferencesEntryKey);
    if (userCredentials == null) {
      return false;
    }

    final credentialsMap = json.decode(userCredentials) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(credentialsMap["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      preferencesInstance.clear();
      return false;
    }
    emit(
      UserCredentials(
        userId: credentialsMap["userId"],
        token: credentialsMap["token"],
        expiryDate: expiryDate,
      ),
    );
    _setAutomaticLogoutTimer();
    return true;
  }

  Future logOut() async {
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
      _logoutTimer = null;
    }
    emit(UserCredentials.empty());

    final preferencesInstance = await SharedPreferences.getInstance();
    preferencesInstance.clear();
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

  Future _storeToken() async {
    final preferencesInstance = await SharedPreferences.getInstance();
    final userCredentials = json.encode({
      "token": state.token,
      "userId": state.userId,
      "expiryDate": state.expiryDate?.toIso8601String(),
    });

    preferencesInstance.setString(preferencesEntryKey, userCredentials);
  }
}
