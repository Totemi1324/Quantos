import 'dart:async';

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/exceptions.dart';

class StorageService extends Cubit<String> {
  static const downloadsPath = "downloads";
  static const downloadsLocalizationFile = "content.json";

  static const baseFile = "base.json";

  final _storage = FirebaseStorage.instance;

  StorageService() : super("");

  Future getDownloadBase() async {
    const path = "$downloadsPath/$baseFile";
    final string = await _getString(path);
    emit(string);
  }

  Future getDownloadLocalization(Locale locale) async {
    final path =
        "$downloadsPath/${locale.languageCode}/$downloadsLocalizationFile";
    final string = await _getString(path);
    emit(string);
  }

  Future<String> _getString(String path) async {
    try {
      _ensureConnectivity();
      final ref = _storage.ref(path);
      final data = await ref.getData();
      if (data == null) {
        throw DownloadFailedException();
      }
      return String.fromCharCodes(data);
    } on FirebaseException {
      throw DownloadFailedException();
    } on DownloadFailedException {
      rethrow;
    }
  }

  Future _ensureConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return;
    } else {
      throw NoInternetException();
    }
  }
}
