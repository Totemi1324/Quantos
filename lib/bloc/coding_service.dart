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
          final results = Sampler.simulate(hamiltonian, recordLength: event.qubo.size <= 2 ? null : 5);

          emit(ConsoleContent(ConsoleStatus.success, record: results));
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

          emit(ConsoleContent(ConsoleStatus.success, record: results));
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
}