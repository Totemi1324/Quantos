import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/lection.dart';
import '../models/lesson.dart';
import '../models/content/content_item.dart';
import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';
import '../models/content/interactive.dart';

class LessonManager {
  final Locale locale;

  LessonManager(this.locale);

  static LessonManager? of(BuildContext context) {
    return Localizations.of<LessonManager>(context, LessonManager);
  }

  static const LocalizationsDelegate<LessonManager> delegate =
      _LessonManagerDelegate();

  final List<Lection> _lections = [
    Lection(
      id: "1",
      iconAnimationAsset:
          "assets/animations/icon_introduction_to_quantum_annealers.riv",
      headerAnimationAsset:
          "assets/animations/introduction_to_quantum_annealers.riv",
      difficultyLevel: Difficulty.easy,
    ),
    Lection(
      id: "2",
      iconAnimationAsset: "assets/animations/icon_the_n_queens_problem.riv",
      headerAnimationAsset: "assets/animations/the_n_queens_problem.riv",
      difficultyLevel: Difficulty.advanced,
    ),
    Lection(
      id: "3",
      iconAnimationAsset:
          "assets/animations/icon_the_traveling_salesman_problem.riv",
      headerAnimationAsset:
          "assets/animations/the_traveling_salesman_problem.riv",
      difficultyLevel: Difficulty.challenging,
    ),
    Lection(
      id: "4",
      iconAnimationAsset: "assets/animations/icon_solving_sudoku_riddles.riv",
      headerAnimationAsset: "",
      difficultyLevel: Difficulty.advanced,
    ),
  ];

  Future<bool> load() async {
    final jsonString =
        await rootBundle.loadString("lessons/${locale.languageCode}.json");
    final jsonMap = json.decode(jsonString);

    //Converter logic

    return true;
  }

  List<Lection> lectionList() {
    return _lections;
  }

  Lection lection(String lectionId) {
    return _lections.firstWhere((lection) => lection.id == lectionId);
  }

  Lesson lesson(String lectionId, String lessonId) {
    return lection(lectionId)
        .lessons
        .firstWhere((lesson) => lesson.id == lessonId);
  }

  List<String> lessonOutline(String lectionId, String lessonId) {
    return lesson(lectionId, lessonId)
        .content
        .where((item) => item.type == ContentType.sectionTitle)
        .map((e) => (e as SectionTitle).title)
        .toList();
  }

  double get cumulativeProgress =>
      _lections
          .map((lection) => lection.progressPercent)
          .reduce((value, number) => value + number) /
      _lections.length;
}

class _LessonManagerDelegate extends LocalizationsDelegate<LessonManager> {
  const _LessonManagerDelegate();

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  Future<LessonManager> load(Locale locale) async {
    final localizations = LessonManager(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LessonManager> old) =>
      false;
}
