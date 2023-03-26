import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState {
  playing,
  stopped,
}

class TextToSpeechService extends Cubit<TtsState> {
  late FlutterTts _tts;

  TextToSpeechService() : super(TtsState.stopped) {
    _tts = FlutterTts();
    _tts.setCompletionHandler(() {
      emit(TtsState.stopped);
    });
  }

  Future setLanguage(Locale locale) async {
    final language = _addCountryCode(locale.languageCode);
    if (!await _tts.isLanguageAvailable(language)) {
      return;
    }

    await _tts.setLanguage(language);
  }

  Future speak(String text) async {
    if (state == TtsState.playing) return;

    await _tts.setVolume(1.0);
    await _tts.setPitch(0);
    await _tts.setSpeechRate(0.7);

    var result = await _tts.speak(text);
    if (result == 1) emit(TtsState.playing);
  }

  Future stop() async {
    if (state != TtsState.playing) return;

    var result = await _tts.stop();
    if (result == 1) emit(TtsState.stopped);
  }

  String _addCountryCode(String languageCode) {
    switch (languageCode) {
      case "de":
        return "de-DE";
      case "en":
        return "en-US";
      default:
        return languageCode;
    }
  }
}
