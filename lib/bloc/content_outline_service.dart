import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter/services.dart';

import '../models/lection.dart';
import '../models/lesson.dart';
import '../models/content/content_outline.dart';
import '../models/exceptions.dart';

class ContentOutlineService extends Cubit<ContentOutline> {
  static const lectionJsonKey = "lection";
  static const lessonJsonKey = "lesson";
  static const titleJsonKey = "title";
  static const descriptionJsonKey = "description";
  static const contentJsonKey = "content";

  static final List<Lection> _contentData = [
    Lection(
      id: "8hg",
      iconAnimationAsset: "icon_introduction_to_quantum_annealers.riv",
      headerAnimationAsset: "introduction_to_quantum_annealers.riv",
      difficultyLevel: Difficulty.easy,
      lessons: [
        Lesson(
          id: "S6N",
          readTimeInMinutes: 4,
        ),
        Lesson(
          id: "75N",
          readTimeInMinutes: 3,
        ),
        Lesson(
          id: "XOQ",
          readTimeInMinutes: 5,
        ),
        Lesson(
          id: "WrU",
          readTimeInMinutes: 6,
        ),
        Lesson(
          id: "Bwk",
          readTimeInMinutes: 4,
        ),
      ],
      unlocked: true,
    ),
    Lection(
      id: "fC9",
      iconAnimationAsset: "icon_the_n_queens_problem.riv",
      headerAnimationAsset: "the_n_queens_problem.riv",
      difficultyLevel: Difficulty.advanced,
      lessons: [
        Lesson(
          id: "uFZ",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "cOU",
          readTimeInMinutes: 3,
        ),
        Lesson(
          id: "t8i",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "qhs",
          readTimeInMinutes: 4,
        ),
        Lesson(
          id: "rdx",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "nAh",
          readTimeInMinutes: 1,
        ),
      ],
      unlocked: true,
    ),
    Lection(
      id: "chj",
      iconAnimationAsset: "icon_the_traveling_salesman_problem.riv",
      headerAnimationAsset: "the_traveling_salesman_problem.riv",
      difficultyLevel: Difficulty.challenging,
      lessons: [
        Lesson(
          id: "wgr",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "CWC",
          readTimeInMinutes: 3,
        ),
        Lesson(
          id: "Bgf",
          readTimeInMinutes: 3,
        ),
        Lesson(
          id: "lNJ",
          readTimeInMinutes: 5,
        ),
        Lesson(
          id: "56h",
          readTimeInMinutes: 4,
        ),
        Lesson(
          id: "IQu",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "Y7A",
          readTimeInMinutes: 1,
        ),
      ],
      unlocked: true,
    ),
    Lection(
      id: "BiE",
      iconAnimationAsset: "icon_solving_sudoku_riddles.riv",
      headerAnimationAsset: "",
      difficultyLevel: Difficulty.advanced,
      lessons: [
        Lesson(
          id: "2D9",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "A3P",
          readTimeInMinutes: 5,
        ),
        Lesson(
          id: "PBv",
          readTimeInMinutes: 2,
        ),
        Lesson(
          id: "kJN",
          readTimeInMinutes: 2,
        ),
      ],
    ),
  ];

  ContentOutlineService() : super(ContentOutline.emptyFromData(_contentData));

  List<Lection> get lections => _contentData;

  List<Lesson> get lessonsFlat => _contentData
      .map((lection) => lection.lessons)
      .expand((list) => list)
      .toList();

  double get cumulativeProgress =>
      _contentData
          .map((lection) => lection.progressPercent)
          .reduce((value, number) => value + number) /
      _contentData.length;

  //Queries
  Lection lection(String lectionId) {
    return _contentData.firstWhere((lection) => lection.id == lectionId);
  }

  Lesson lesson(String lessonId) {
    return lessonsFlat.firstWhere((lesson) => lesson.id == lessonId);
  }

  //State management
  Future loadFromLocale(Locale locale) async {
    final jsonString =
        await rootBundle.loadString("lessons/${locale.languageCode}/base.json");

    _parse(jsonString);

    emit(state);
  }

  void _parse(String jsonString) {
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    for (var entry in jsonMap.entries) {
      if (entry.key.substring(0, 8) != "$lectionJsonKey-") {
        throw ParseErrorException(
          ParseError.invalidJsonEntry,
          wrongContent: entry.key,
        );
      }
      final lectionId = entry.key.substring(8);
      if (entry.value is Map<String, dynamic>) {
        _parseLection(lectionId, entry.value as Map<String, dynamic>);
      } else {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
    }
  }

  void _parseLection(String id, Map<String, dynamic> lectionMap) {
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

    state.updateLectionData(
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
      _parseContents(lectionMap[contentJsonKey]);
    } else {
      throw ParseErrorException(
        ParseError.invalidJsonValue,
        wrongContent: contentJsonKey,
      );
    }
  }

  void _parseContents(Map<String, dynamic> content) {
    for (var entry in content.entries) {
      if (entry.key.substring(0, 7) != "$lessonJsonKey-") {
        throw ParseErrorException(
          ParseError.invalidJsonEntry,
          wrongContent: entry.key,
        );
      }
      final lessonId = entry.key.substring(7);
      if (entry.value is Map<String, dynamic>) {
        _parseLesson(lessonId, entry.value);
      } else {
        throw ParseErrorException(
          ParseError.invalidJsonValue,
          wrongContent: entry.key,
        );
      }
    }
  }

  void _parseLesson(String lessonId, Map<String, dynamic> lessonMap) {
    if (!lessonMap.keys.contains(titleJsonKey)) {
      throw ParseErrorException(
        ParseError.incompleteJsonObject,
        wrongContent: titleJsonKey,
      );
    }

    state.updateLessonData(lessonId, lessonMap[titleJsonKey]);
  }
}
