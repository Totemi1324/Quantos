import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/authentication_service.dart';
import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';
import '../bloc/localization_service.dart';
import '../bloc/database_service.dart';
import '../bloc/download_service.dart';
import '../bloc/storage_service.dart';

Future<dynamic> getDefaultLoadingRoutine(BuildContext buildContext) {
  return Future(
    () async {
      final contentOutlineService = buildContext.read<ContentOutlineService>();
      final databaseService = buildContext.read<DatabaseService>();
      final authenticationService = buildContext.read<AuthenticationService>();
      final downloadService = buildContext.read<DownloadService>();
      final storageService = buildContext.read<StorageService>();
      final currentLocale = buildContext.read<LocalizationService>().state;

      await databaseService.getUserInfo(
        authenticationService.state.userId,
      );
      await contentOutlineService.loadFromLocale(currentLocale);

      try {
        await storageService.getDownloadBase();
        if (storageService.state.hasData) {
          await downloadService.loadBase(storageService.state.content);

          storageService.getDownloadLocalization(currentLocale);
          final currentDownloadData = storageService.state.content;
          storageService.getDownloadLocalization(const Locale("en"));
          final fallbackDownloadData = storageService.state.content;

          await downloadService.loadFromLocale(
              currentDownloadData, fallbackDownloadData);
        }
      } on Exception {
        downloadService.clear();
      }
    },
  );
}

Future<dynamic> getLessonLoadingRoutine(
    BuildContext buildContext, String lessonId) {
  return Future(
    () async {
      final lessonContentService = buildContext.read<LessonContentService>();

      await lessonContentService.loadByIdFromLocale(
        lessonId,
        buildContext.read<LocalizationService>().state,
        AppLocalizations.of(buildContext)!,
      );
    },
  );
}
