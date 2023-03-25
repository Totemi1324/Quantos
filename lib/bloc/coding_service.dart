import 'dart:math';

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

class GiveError extends CodingEvent {}

class CodingService extends Bloc<CodingEvent, ConsoleContent> {
  String? _tokenEntered;

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

          //TODO: TEMP CODE
          final probabilities = _boltzmannDistribution(
            results.entries().map((entry) => entry.energy).toList(),
            (500 / 16) * event.qubo.size / 100.0,
          );

          var stringBuilder = "";
          var counter = 1;
          for (var entry in results.entries()) {
            stringBuilder +=
                "#$counter: ${entry.energy.toStringAsFixed(1)} E\n${entry.solutionVector} x ${(500 * probabilities[counter - 1]).round()}";
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

    on<GiveError>(
      (event, emit) {
        emit(const ConsoleContent(ConsoleStatus.failure));
      },
    );
  }

  void saveTokenInput(String? input) {
    _tokenEntered = input;
  }

  //TODO: TEMP CODE
  List<double> _boltzmannDistribution(
    List<double> energies,
    double temperature,
  ) {
    List<double> factorized = energies.map((e) => -e / temperature).toList();
    double lse = _logsumexp(factorized);
    return factorized.map((e) => exp(e - lse)).toList();
  }

  double _logsumexp(List<double> numbers) {
    double c = numbers.fold(0, (v1, v2) => max(v1, v2));
    return c + log(numbers.map((n) => exp(n - c)).fold(0, (a, b) => a + b));
  }
}
