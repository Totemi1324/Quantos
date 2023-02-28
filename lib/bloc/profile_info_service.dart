import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/profile_info.dart';

class ProfileInfoService extends Cubit<ProfileInfo> {
  ProfileInfoService() : super(ProfileInfo.empty());

  void updateName(String newName) {
    emit(ProfileInfo(
      name: newName,
      team: state.team,
      age: state.age,
      experience: state.experience,
      firstTimeCoding: state.firstTimeCoding,
    ));
  }

  void eraseName() {
    emit(ProfileInfo(
      name: null,
      team: state.team,
      age: state.age,
      experience: state.experience,
      firstTimeCoding: state.firstTimeCoding,
    ));
  }

  void updateAge(Age newAge) {
    emit(ProfileInfo(
      name: state.name,
      team: state.team,
      age: newAge,
      experience: state.experience,
      firstTimeCoding: state.firstTimeCoding,
    ));
  }

  void updateExperience(Experience newExperience) {
    emit(ProfileInfo(
      name: state.name,
      team: state.team,
      age: state.age,
      experience: newExperience,
      firstTimeCoding: state.firstTimeCoding,
    ));
  }

  void visitedCodingScreen() {
    emit(ProfileInfo(
      name: state.name,
      team: state.team,
      age: state.age,
      experience: state.experience,
      firstTimeCoding: false,
    ));
  }
}
