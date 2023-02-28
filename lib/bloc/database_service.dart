import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user_data.dart';
import '../models/content/content_outline.dart';

class DatabaseService extends Cubit<UserData> { //TODO: Save preferences
  final _database = FirebaseDatabase.instance;
  late ContentOutline _outlineInstance;

  DatabaseService(ContentOutline outline) : super(UserData.defaultUser(outline)) {
    _database.setPersistenceEnabled(true);
    _outlineInstance = outline;
  }

  double get cumulativeProgress => state.lessonProgress.values.reduce((value, number) => value + number) / state.lessonProgress.values.length;

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

  // Database interaction
  Future initializeUserEntry(String userId) async {
    final ref = _database.ref("users/$userId");
    final activityMap = Map.fromIterables(
      state.activityLog.keys.map((time) => time.toIso8601String()),
      state.activityLog.values,
    );

    await ref.set({
      "name": state.name,
      "team": state.team,
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
      "team": state.team,
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

  // Local queries
  bool isUnlocked(String lectionId) => state.lectionUnlocked[lectionId] ?? true;

  double lectionProgress(String lectionId) {
    if (_outlineInstance.lessonGrouping[lectionId] == null) {
      return 0.0;
    }

    final lessonEntriesOfLection = state.lessonProgress.entries
      .where((entry) => _outlineInstance.lessonGrouping[lectionId]!
      .contains(entry.key));
    return lessonEntriesOfLection.map((entry) => entry.value)
      .reduce((value, number) => value + number) / lessonEntriesOfLection.length;
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
        state.lessonProgress = Map.fromIterables(
          child.children.map((c) => c.key as String),
          child.children.map((c) => c.value is int ? (c.value as int).toDouble() : c.value as double),
        );
        break;
      case "unlocked":
        state.lectionUnlocked = Map.fromIterables(
          child.children.map((c) => c.key as String),
          child.children.map((c) => c.value as bool),
        );
    } 
  }
}
