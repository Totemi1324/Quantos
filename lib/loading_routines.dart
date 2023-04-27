import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './bloc/authentication_service.dart';
import './bloc/content_outline_service.dart';
import './bloc/lesson_content_service.dart';
import './bloc/localization_service.dart';
import './bloc/database_service.dart';
import './bloc/download_service.dart';
import './bloc/storage_service.dart';

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

      try {
        await storageService.getContentBase();
        if (storageService.state.hasData) {
          contentOutlineService.loadBase(storageService.state.content);
          contentOutlineService.getAssetLocations();

          await storageService.getContentLocalization(currentLocale);
          contentOutlineService.loadFromLocale(storageService.state.content);
        }
      } on Exception {
        contentOutlineService.clear();
      }

      try {
        await storageService.getDownloadBase();
        if (storageService.state.hasData) {
          downloadService.loadBase(storageService.state.content);

          await storageService.getDownloadLocalization(currentLocale);
          final currentDownloadData = storageService.state.content;
          await storageService.getDownloadLocalization(const Locale("en"));
          final fallbackDownloadData = storageService.state.content;

          downloadService.loadFromLocale(
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
      final storageService = buildContext.read<StorageService>();
      final localizationService = buildContext.read<LocalizationService>();
      final appLocalizations = AppLocalizations.of(buildContext)!;

      await storageService.getLessonContent(
          localizationService.state, lessonId);
      if (storageService.state.hasData) {
        final isNew = lessonContentService.loadByIdFromLocale(
          lessonId,
          storageService.state.content,
          appLocalizations,
        );
        if (isNew) {
          await lessonContentService.getDownloadLinks(storageService);
        }
      }
    },
  );
}

Future<dynamic> getUpdateCurrentUserLoadingRoutine(BuildContext buildContext) {
  return Future(() async {
    final authenticationService = buildContext.read<AuthenticationService>();
    final databaseService = buildContext.read<DatabaseService>();

    if (authenticationService.isAuthenticated) {
      await databaseService
          .updateProfileInfo(authenticationService.state.userId);
    }
  });
}
