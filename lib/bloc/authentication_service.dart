import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/user_credentials.dart';
import '../credentials.dart';

class AuthenticationService extends Cubit<UserCredentials> {
  AuthenticationService() : super(UserCredentials.empty());

  Future attemptSignUp(String email, String password) async {
    //TODO Errors when empty credentials
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
  }
}
