import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:tuple/tuple.dart';

import '../models/user_data.dart';
import '../models/content/content_outline.dart';

class DatabaseService extends Cubit<UserData> {
  //TODO: Save preferences
  final _database = FirebaseDatabase.instance;
  late ContentOutline _outlineInstance;

  DatabaseService(ContentOutline outline)
      : super(UserData.defaultUser(outline)) {
    if (!UniversalPlatform.isWeb) {
      _database.setPersistenceEnabled(true);
    }
    _outlineInstance = outline;
  }

  double get cumulativeProgress =>
      state.lessonProgress.values.reduce((value, number) => value + number) /
      state.lessonProgress.values.length;

  // State management
  void fullReset() => emit(UserData.defaultUser(_outlineInstance));

  void updateName(String? newName) {
    state.name = newName;
    emit(state);
  }

  void updateAge(Age newAge) {
    state.age = newAge;
    emit(state);
  }

  void updateExperience(Experience newExperience) {
    state.experience = newExperience;
    emit(state);
  }

  void updateProgressOfLesson(String lessonId, double progress, String userId) {
    if (state.lessonProgress[lessonId] == null) {
      return;
    }

    if (progress > state.lessonProgress[lessonId]!) {
      final lessonProgress = state.lessonProgress;
      lessonProgress[lessonId] = progress;
      emit(
        UserData(
          name: state.name,
          team: state.team,
          age: state.age,
          experience: state.experience,
          lectionUnlocked: state.lectionUnlocked,
          lessonProgress: lessonProgress,
          activityLog: state.activityLog,
        ),
      );
      unawaited(
        updateProgress(userId, lessonId),
      );
    }
  }

  // Database interaction
  Future initializeUserEntry(String userId, {String? team}) async {
    final ref = _database.ref("users/$userId");
    final activityMap = Map.fromIterables(
      state.activityLog.keys.map((time) => time.toIso8601String()),
      state.activityLog.values,
    );

    await ref.set({
      "name": state.name,
      "team": team ?? state.team,
      "age": state.age.index,
      "experience": state.experience.index,
      "unlocked": state.lectionUnlocked,
      "progress": state.lessonProgress,
      "activity": activityMap,
    });
  }

  Future updateProfileInfo(String userId) async {
    final ref = _database.ref("users/$userId");

    await ref.update({
      "name": state.name,
      "age": state.age.index,
      "experience": state.experience.index,
    });
  }

  Future getUserInfo(String userId) async {
    final ref = _database.ref("users/$userId");
    final data = await ref.get();
    if (data.exists) {
      for (var child in data.children) {
        _parseDataChild(child);
      }
    }

    emit(state);
  }

  Future updateProgress(String userId, String lessonId) async {
    final ref = _database.ref("users/$userId/progress");

    await ref.update({
      lessonId: state.lessonProgress[lessonId],
    });
  }

  Future<bool> accessCodeExists(String accessCode) async {
    final ref = _database.ref("accesscodes");
    final event = await ref.child(accessCode).once(DatabaseEventType.value);

    return event.snapshot.exists;
  }

  Future<Tuple2<bool, String?>> getAccessCodeInfo(String accessCode) async {
    final ref = _database.ref("accesscodes/$accessCode");
    final data = await ref.get();
    bool active = false;
    String? team;

    if (data.exists) {
      for (var child in data.children) {
        switch (child.key) {
          case "team":
            team = child.value as String?;
            break;
          case "active":
            active = (child.value ?? false) as bool;
            break;
        }
      }
    }

    return Tuple2(active, team);
  }

  Future<bool> accessCodeHasSignedUp(String accessCode) async {
    final ref = _database.ref("users");
    final event = await ref.child(accessCode).once(DatabaseEventType.value);

    return event.snapshot.exists;
  }

  // Local queries
  bool isUnlocked(String lectionId) => state.lectionUnlocked[lectionId] ?? true;

  double lessonProgress(String lessonId) =>
      state.lessonProgress[lessonId] ?? 0.0;

  double lectionProgress(String lectionId) {
    if (_outlineInstance.lessonGrouping[lectionId] == null) {
      return 0.0;
    }

    final lessonEntriesOfLection = state.lessonProgress.entries.where((entry) =>
        _outlineInstance.lessonGrouping[lectionId]!.contains(entry.key));
    return lessonEntriesOfLection
            .map((entry) => entry.value)
            .reduce((value, number) => value + number) /
        lessonEntriesOfLection.length;
  }

  // Private helper methods
  void _parseDataChild(DataSnapshot child) {
    if (child.value == null) {
      return;
    }

    switch (child.key) {
      case "name":
        state.name = child.value as String;
        break;
      case "team":
        state.team = child.value as String;
        break;
      case "age":
        state.age = Age.values[child.value as int];
        break;
      case "experience":
        state.experience = Experience.values[child.value as int];
        break;
      case "progress":
        for (child in child.children) {
          state.lessonProgress[child.key as String] = child.value is int
              ? (child.value as int).toDouble()
              : child.value as double;
        }
        break;
      case "unlocked":
        for (child in child.children) {
          state.lectionUnlocked[child.key as String] = child.value as bool;
        }
        break;
    }
  }
}
