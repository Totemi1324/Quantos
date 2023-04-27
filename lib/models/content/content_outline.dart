import '../lection.dart';
import '../exceptions.dart';

class ContentOutline {
  final List<String> lectionIds;
  final List<String> lessonIds;
  final Map<String, List<String>> lessonGrouping;
  final Map<String, String> lectionTitles;
  final Map<String, String> lectionDescriptions;
  final Map<String, String> lessonTitles;

  const ContentOutline({
    required this.lectionIds,
    required this.lessonIds,
    required this.lessonGrouping,
    required this.lectionTitles,
    required this.lectionDescriptions,
    required this.lessonTitles,
  });

  factory ContentOutline.empty() => const ContentOutline(
        lectionIds: [],
        lessonIds: [],
        lessonGrouping: {},
        lectionTitles: {},
        lectionDescriptions: {},
        lessonTitles: {},
      );

  factory ContentOutline.emptyFromData(List<Lection> contentData) {
    final List<String> lectionIds =
        contentData.map((lection) => lection.id).toList();
    final List<String> lessonIds = contentData
        .map((lection) => lection.lessons)
        .map((lessonList) => lessonList.map((lesson) => lesson.id).toList())
        .expand((list) => list)
        .toList();
    final Map<String, List<String>> lessonGrouping = {};
    final Map<String, String> lectionTitles = {};
    final Map<String, String> lectionDescriptions = {};
    final Map<String, String> lessonTitles = {};

    for (var lectionId in lectionIds) {
      final lection =
          contentData.firstWhere((lection) => lection.id == lectionId);
      lessonGrouping[lectionId] =
          lection.lessons.map((lesson) => lesson.id).toList();
      lectionTitles[lectionId] = "";
      lectionDescriptions[lectionId] = "";
    }

    for (var lessonId in lessonIds) {
      lectionTitles[lessonId] = "";
    }

    return ContentOutline(
      lectionIds: lectionIds,
      lessonIds: lessonIds,
      lessonGrouping: lessonGrouping,
      lectionTitles: lectionTitles,
      lectionDescriptions: lectionDescriptions,
      lessonTitles: lessonTitles,
    );
  }

  String getLectionTitle(String lectionId) {
    if (!lectionIds.contains(lectionId)) {
      return "";
    }
    return lectionTitles[lectionId]!;
  }

  String getLectionDescription(String lectionId) {
    if (!lectionIds.contains(lectionId)) {
      return "";
    }
    return lectionDescriptions[lectionId]!;
  }

  String getLessonTitle(String lessonId) {
    if (!lessonIds.contains(lessonId)) {
      return "";
    }
    return lessonTitles[lessonId]!;
  }

  List<String> getLessonsOfLection(String lectionId) {
    if (!lectionIds.contains(lectionId)) {
      return List<String>.empty();
    }
    return lessonGrouping[lectionId]!;
  }

  void updateLectionData(
      String lectionId, String lectionTitle, String lectionDescription) {
    if (!lectionIds.contains(lectionId)) {
      throw ParseErrorException(
        ParseError.lectionIdDoesNotExist,
        wrongContent: lectionId,
      );
    }

    lectionTitles[lectionId] = lectionTitle;
    lectionDescriptions[lectionId] = lectionDescription;
  }

  void updateLessonData(String lessonId, String lessonTitle) {
    if (!lessonIds.contains(lessonId)) {
      throw ParseErrorException(
        ParseError.lessonIdDoesNotExist,
        wrongContent: lessonId,
      );
    }

    lessonTitles[lessonId] = lessonTitle;
  }

  void clearData() {
    for (var key in lectionTitles.keys) {
      lectionTitles[key] = "";
    }
    for (var key in lectionDescriptions.keys) {
      lectionDescriptions[key] = "";
    }
    for (var key in lessonTitles.keys) {
      lessonTitles[key] = "";
    }
  }
}
