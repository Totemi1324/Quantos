import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';

import 'content_parser.dart';

import '../models/download_store.dart';

class DownloadService extends Cubit<DownloadStore> {
  DownloadService() : super(DownloadStore.empty());
}