import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/profile_info.dart';

class DatabaseService extends Cubit<UserData> {
  final database = FirebaseDatabase.instance;

  DatabaseService() : super(UserData.empty());
}
