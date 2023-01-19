import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LocalizationService extends Cubit<Locale> {
  final BuildContext currentContext;
  
  static final _supportedLocales = [
    const Locale('en', 'US'),
    const Locale('de', 'DE'),
  ];

  static Locale _currentLocale = _supportedLocales[0];

  LocalizationService(this.currentContext) : super(_currentLocale);

  List<Locale> get supportedLocales => _supportedLocales;
  Locale get currentLocale => _currentLocale;
}