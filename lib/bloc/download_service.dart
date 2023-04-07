import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

import 'content_parser.dart';

import '../models/download_store.dart';
import '../models/platform.dart';
//TEMP
import '../data/downloads.dart';
import '../data/download_categories.dart';

class DownloadService extends Cubit<DownloadStore> {
  DownloadService()
      : super(DownloadStore(categories: downloadCategories, items: downloads));

  Platform get currentPlatform {
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return Platform.mobile;
    }
    if (UniversalPlatform.isWeb || UniversalPlatform.isMacOS) {
      return Platform.desktop;
    }
    return Platform.undefined;
  }
}
