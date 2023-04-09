import 'dart:convert';

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

import 'content_parser.dart';

import '../models/download_store.dart';
import '../models/platform.dart';
import '../models/exceptions.dart';

class DownloadService extends Cubit<DownloadStore> {
  static const categoriesJsonKey = "categories";
  static const itemsJsonKey = "items";

  DownloadService() : super(DownloadStore.empty());

  Platform get currentPlatform {
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return Platform.mobile;
    }
    if (UniversalPlatform.isWeb || UniversalPlatform.isMacOS) {
      return Platform.desktop;
    }
    return Platform.undefined;
  }

  Future loadBase() async {
    state.clear();

    try {
      final jsonString = await rootBundle.loadString("downloads/base.json");

      _parseBase(jsonString);
    } on Exception catch (exception) {
      emit(DownloadStore.empty());
      throw ProcessFailedException(exception);
      //return;
    }

    emit(state);
  }

  Future loadFromLocale(Locale locale) async {
    try {
      final jsonString =
          await rootBundle.loadString("downloads/${locale.languageCode}.json");

      _parseLocale(jsonString);
    } on Exception catch (exception) {
      if (locale.languageCode != "en") {
        await loadFromLocale(const Locale('en'));
      } else {
        emit(DownloadStore.empty());
        throw ProcessFailedException(exception);
        //return;
      }
    }

    emit(DownloadStore(categories: state.categories, items: state.items));
  }

  void _parseBase(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.value is! Map<String, dynamic>) {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
      final ids = entry.value as Map<String, dynamic>;

      switch (entry.key) {
        case categoriesJsonKey:
          for (var id in ids.keys) {
            if (ids[id] is! Map<String, dynamic>) {
              throw ParseErrorException(
                ParseError.invalidJsonValue,
                wrongContent: id,
              );
            }
            state.addCategory(ContentParser.parseDownloadCategory(id, ids[id]));
          }
          break;
        case itemsJsonKey:
          for (var id in ids.keys) {
            if (ids[id] is! Map<String, dynamic>) {
              throw ParseErrorException(
                ParseError.invalidJsonValue,
                wrongContent: id,
              );
            }
            state.addItem(ContentParser.parseDownload(id, ids[id]));
          }
          break;
        default:
          throw ParseErrorException(
            ParseError.invalidJsonEntry,
            wrongContent: entry.key,
          );
      }
    }
  }

  void _parseLocale(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.value is! Map<String, dynamic>) {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
      final ids = entry.value as Map<String, dynamic>;

      switch (entry.key) {
        case categoriesJsonKey:
          for (var id in ids.keys) {
            if (ids[id] is! String) {
              throw ParseErrorException(
                ParseError.invalidJsonValue,
                wrongContent: id,
              );
            }
            final previous = state.getCategoryById(id);
            if (previous != null) {
              state.updateCategory(
                id,
                ContentParser.updateDownloadCategoryLocalization(
                  previous,
                  ids[id],
                ),
              );
            }
          }
          break;
        case itemsJsonKey:
          for (var id in ids.keys) {
            if (ids[id] is! Map<String, dynamic>) {
              throw ParseErrorException(
                ParseError.invalidJsonValue,
                wrongContent: id,
              );
            }
            final previous = state.getDownloadById(id);
            if (previous != null) {
              state.updateItem(
                id,
                ContentParser.updateDownloadLocalization(
                  previous,
                  ids[id],
                ),
              );
            }
          }
          break;
        default:
          throw ParseErrorException(
            ParseError.invalidJsonEntry,
            wrongContent: entry.key,
          );
      }
    }
  }
}
