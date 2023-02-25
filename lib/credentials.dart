import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class Credentials {
  final String firebaseApiKey;

  const Credentials({required this.firebaseApiKey});

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      Credentials(firebaseApiKey: json["values"]["firebaseApiKey"]);
}

class CredentialsLoader {
  static Future<Credentials> load() {
    return rootBundle.loadStructuredData<Credentials>(
      "lib/credentials.json",
      (jsonString) async => Credentials.fromJson(json.decode(jsonString)),
    );
  }
}
