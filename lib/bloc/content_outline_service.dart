import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';

import './content_parser.dart';
import './storage_service.dart';

import '../models/lection.dart';
import '../models/lesson.dart';
import '../models/content/content_outline.dart';
import '../models/exceptions.dart';

class ContentOutlineService extends Cubit<ContentOutline> {
  static const lectionsJsonKey = "lections";

  static const lectionJsonKey = "lection";
  static const lessonJsonKey = "lesson";
  static const titleJsonKey = "title";
  static const descriptionJsonKey = "description";
  static const contentJsonKey = "content";

  static const animationsPath = "assets/animations/lections";

  static List<Lection> _base = [];

  ContentOutlineService() : super(ContentOutline.empty());

  List<Lection> get lections => _base;

  List<Lesson> get lessonsFlat =>
      _base.map((lection) => lection.lessons).expand((list) => list).toList();

  //Queries
  Lection lection(String lectionId) {
    return _base.firstWhere((lection) => lection.id == lectionId);
  }

  Lesson lesson(String lessonId) {
    return lessonsFlat.firstWhere((lesson) => lesson.id == lessonId);
  }

  //State management
  void loadBase(String jsonString) {
    try {
      final newState = _parseBase(jsonString);

      emit(newState);
    } on Exception catch (exception) {
      emit(ContentOutline.empty());
      throw ProcessFailedException(exception);
    }
  }

  Future loadFromLocale(String jsonString) async {
    if (_base.isEmpty) {
      return;
    }

    try {
      final newState = _parseLocale(jsonString);

      emit(newState);
    } on Exception catch (exception) {
      throw ProcessFailedException(exception);
    }
  }

  Future getDownloadLinks(StorageService storageService) async {
    for (var lection in _base) {
      await lection.getDownloadLinks(storageService);
    }
  }

  void getAssetLocations() {
    for (var lection in _base) {
      lection.getAssetLocations(animationsPath);
    }
  }

  void clear() {
    _base.clear();
    emit(ContentOutline.empty());
  }

  ContentOutline _parseBase(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final content = <Lection>[];

    if (!jsonMap.containsKey(lectionsJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: lectionsJsonKey,
      );
    }
    if (jsonMap[lectionsJsonKey] is! Map<String, dynamic>) {
      throw ParseErrorException(
        ParseError.invalidJsonEntry,
        wrongContent: lectionsJsonKey,
      );
    }

    final ids = jsonMap[lectionsJsonKey] as Map<String, dynamic>;

    for (var entry in ids.entries) {
      if (entry.value is! Map<String, dynamic>) {
        throw ParseErrorException(
          ParseError.invalidJsonEntry,
          wrongContent: entry.key,
        );
      }

      content.add(ContentParser.parseLection(entry.key, entry.value));
    }

    _base = content;

    return ContentOutline.emptyFromData(_base);
  }

  ContentOutline _parseLocale(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final result = ContentOutline.emptyFromData(_base);

    for (var entry in jsonMap.entries) {
      if (entry.key.substring(0, 8) != "$lectionJsonKey-") {
        throw ParseErrorException(
          ParseError.invalidJsonEntry,
          wrongContent: entry.key,
        );
      }
      final lectionId = entry.key.substring(8);
      if (entry.value is Map<String, dynamic>) {
        _parseLection(lectionId, entry.value as Map<String, dynamic>, result);
      } else {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
    }

    return result;
  }

  void _parseLection(
      String id, Map<String, dynamic> lectionMap, ContentOutline currentState) {
    if (!lectionMap.keys.contains(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }
    if (!lectionMap.keys.contains(descriptionJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: descriptionJsonKey,
      );
    }

    currentState.updateLectionData(
      id,
      lectionMap[titleJsonKey],
      lectionMap[descriptionJsonKey],
    );

    if (!lectionMap.keys.contains(contentJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: contentJsonKey,
      );
    }
    if (lectionMap[contentJsonKey] is Map<String, dynamic>) {
      _parseContents(lectionMap[contentJsonKey], currentState);
    } else {
      throw ParseErrorException(
        ParseError.invalidJsonValue,
        wrongContent: contentJsonKey,
      );
    }
  }

  void _parseContents(
      Map<String, dynamic> content, ContentOutline currentState) {
    for (var entry in content.entries) {
      if (entry.key.substring(0, 7) != "$lessonJsonKey-") {
        throw ParseErrorException(
          ParseError.invalidJsonEntry,
          wrongContent: entry.key,
        );
      }
      final lessonId = entry.key.substring(7);
      if (entry.value is Map<String, dynamic>) {
        _parseLesson(lessonId, entry.value, currentState);
      } else {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
    }
  }

  void _parseLesson(String lessonId, Map<String, dynamic> lessonMap,
      ContentOutline currentState) {
    if (!lessonMap.keys.contains(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }

    currentState.updateLessonData(lessonId, lessonMap[titleJsonKey]);
  }
}
