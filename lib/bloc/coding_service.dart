import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubo_embedder/qubo_embedder.dart';
// ignore: implementation_imports
import 'package:qubo_embedder/src/exceptions.dart';

import '../models/console_content.dart';

abstract class CodingEvent {}

class SendSimulator extends CodingEvent {
  final Qubo qubo;

  SendSimulator(this.qubo);
}

class SendAdvantage extends CodingEvent {
  final Qubo qubo;

  SendAdvantage(this.qubo);
}

class CodingService extends Bloc<CodingEvent, ConsoleContent> {
  CodingService() : super(ConsoleContent.initial()) {
    on<SendSimulator>(
      (event, emit) async {
        emit(const ConsoleContent(ConsoleStatus.loading));

        await Future.delayed(const Duration(milliseconds: 300));
        final hamiltonian = Hamiltonian.fromQubo(event.qubo);

        try {
          final results = Sampler.simulate(hamiltonian);

          var stringBuilder = "";
          var counter = 1;
          for (var entry in results.entries()) {
            stringBuilder +=
                "#$counter: ${entry.energy.toStringAsFixed(1)} E\n${entry.solutionVector} x ${entry.numOccurrences}";
            stringBuilder += "\n\n";
            counter += 1;
          }

          emit(ConsoleContent(ConsoleStatus.success,
              record: results, formatted: stringBuilder));
        } on QuboEmbedderException {
          emit(const ConsoleContent(ConsoleStatus.failure));
        }
      },
    );

    on<SendAdvantage>(
      (event, emit) async {
        emit(const ConsoleContent(ConsoleStatus.loading));

        await Future.delayed(const Duration(seconds: 6));
        final hamiltonian = Hamiltonian.fromQubo(event.qubo);

        try {
          final results = Sampler.simulate(hamiltonian);

          var stringBuilder = "";
          var counter = 0;
          for (var entry in results.entries()) {
            stringBuilder +=
                "#$counter: ${entry.energy.toStringAsFixed(1)} E\n${entry.solutionVector} x ${entry.numOccurrences}";
            stringBuilder += "\n\n";
            counter += 1;
          }

          emit(ConsoleContent(ConsoleStatus.success,
              record: results, formatted: stringBuilder));
        } on QuboEmbedderException {
          emit(const ConsoleContent(ConsoleStatus.failure));
        }
      },
    );
  }
}
