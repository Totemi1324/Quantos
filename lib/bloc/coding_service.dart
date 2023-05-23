import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubo_embedder/qubo_embedder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/console_content.dart';

abstract class CodingEvent {}

class SendSimulator extends CodingEvent {
  final Qubo qubo;

  SendSimulator(this.qubo);
}

class SendAdvantage extends CodingEvent {
  final Qubo qubo;
  final AppLocalizations localizations;

  SendAdvantage(this.qubo, this.localizations);
}

class UpdateToken extends CodingEvent {
  final String? currentToken;

  UpdateToken(this.currentToken);
}

class ClearToken extends CodingEvent {}

class CodingService extends Bloc<CodingEvent, ConsoleContent> {
  static const region = "eu-central-1";
  String? _tokenEntered;

  CodingService() : super(ConsoleContent.initial()) {
    on<SendSimulator>(
      (event, emit) async {
        emit(const ConsoleContent(ConsoleStatus.loading));

        await Future.delayed(const Duration(milliseconds: 300));

        final results = await Solver.simulator().sampleQubo(event.qubo,
            recordLength: event.qubo.size <= 2 ? null : 5);

        emit(ConsoleContent(ConsoleStatus.success, record: results));
      },
    );

    on<SendAdvantage>(
      (event, emit) async {
        emit(const ConsoleContent(ConsoleStatus.loading));

        if (_tokenEntered == null || _tokenEntered!.trim().isEmpty) {
          emit(
            ConsoleContent(
              ConsoleStatus.failure,
              errorMessage:
                  event.localizations.codingConsoleErrorMessageTokenIsEmpty,
            ),
          );
          return;
        }
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          emit(
            ConsoleContent(
              ConsoleStatus.failure,
              errorMessage:
                  event.localizations.codingConsoleErrorMessageNoConnection,
            ),
          );
          return;
        }

        try {
          final available = await DwaveApi.getAvailableQpuSolvers(
              ApiParams(apiRegion: region, apiToken: _tokenEntered!.trim()));
          available.sort((a, b) => a.numQubits.compareTo(b.numQubits));
          final solver = available.last.name;

          final results = await Solver.dwaveSampler(
            region: region,
            solver: solver,
            token: _tokenEntered!,
          ).sampleQubo(event.qubo);

          emit(ConsoleContent(ConsoleStatus.success, record: results));
        } on DwaveApiException catch (exception) {
          String? message;
          switch (exception.dwaveApiError) {
            case DwaveApiError.solverNotAvailable:
              message =
                  event.localizations.codingConsoleErrorMessageNoEmbeddingFound;
              break;
            case DwaveApiError.incorrectApiToken:
              message =
                  event.localizations.codingConsoleErrorMessageTokenIsIncorrect;
              break;
            default:
              message = exception.message;
          }
          emit(ConsoleContent(ConsoleStatus.failure, errorMessage: message));
        } on QuboEmbedderException catch (exception) {
          emit(ConsoleContent(ConsoleStatus.failure,
              errorMessage: exception.message));
        }
      },
    );

    on<UpdateToken>(
      (event, emit) => _tokenEntered = event.currentToken,
    );

    on<ClearToken>(
      (event, emit) => _tokenEntered = null,
    );
  }
}
