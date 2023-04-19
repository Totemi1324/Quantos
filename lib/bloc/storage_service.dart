import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/data_reader.dart';
import '../models/exceptions.dart';

class StorageService extends Cubit<DataReader> {
  static const downloadsPath = "downloads";
  static const downloadsLocalizationFile = "content.json";

  static const baseFile = "base.json";

  final _storage = FirebaseStorage.instance;

  static DownloadError _firebaseErrorCodes(String errorCode) {
    switch (errorCode) {
      case "storage/object-not-found":
        return DownloadError.fileDoesNotExist;
      case "storage/unauthenticated":
        return DownloadError.notAuthenticated;
      default:
        return DownloadError.unknown;
    }
  }

  StorageService() : super(const DataReader());

  Future getDownloadBase() async {
    emit(const DataReader());

    const path = "$downloadsPath/$baseFile";
    final string = await _getString(path);

    emit(DataReader(data: string));
  }

  Future getDownloadLocalization(Locale locale) async {
    emit(const DataReader());

    final path =
        "$downloadsPath/${locale.languageCode}/$downloadsLocalizationFile";
    final string = await _getString(path);

    emit(DataReader(data: string));
  }

  Future<String?> _getString(String path) async {
    const utf8 = Utf8Decoder();

    try {
      _ensureConnectivity();
      final ref = _storage.ref(path);
      final data = await ref.getData();
      return data == null ? null : utf8.convert(data);
    } on FirebaseException catch (error) {
      if (_firebaseErrorCodes(error.code) == DownloadError.fileDoesNotExist) {
        return null;
      } else {
        throw ProcessFailedException(error);
      }
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
