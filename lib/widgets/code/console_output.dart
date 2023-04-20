import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qubo_embedder/qubo_embedder.dart';

import '../../bloc/stores/coding_modes_store_service.dart';
import '../../bloc/coding_service.dart';

import '../../models/console_content.dart';
import '../containers/panel_card.dart';
import '../part_separator.dart';

class ConsoleOutput extends StatefulWidget {
  final CodingMode mode;

  const ConsoleOutput(this.mode, {super.key});

  @override
  State<ConsoleOutput> createState() => _ConsoleOutputState();
}

class _ConsoleOutputState extends State<ConsoleOutput> {
  final scrollController = ScrollController();

  Widget _buildMessageForStatus(
      BuildContext buildContext, ConsoleStatus status) {
    final defaultStyle = Theme.of(buildContext).textTheme.labelMedium;
    const fallbackStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    switch (status) {
      case ConsoleStatus.idle:
        return Text(
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageIdle,
          style: defaultStyle,
        );
      case ConsoleStatus.loading:
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            const SizedBox(
              height: 25,
            ),
            DefaultTextStyle(
              style: defaultStyle ?? fallbackStyle,
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(AppLocalizations.of(buildContext)!
                      .codingConsoleOutputMessageLoading),
                  FadeAnimatedText(AppLocalizations.of(buildContext)!
                      .codingConsoleOutputMessageLoading),
                ],
                repeatForever: true,
              ),
            ),
          ],
        );
      case ConsoleStatus.success:
        return Text(
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageSuccess,
          style: defaultStyle?.copyWith(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      case ConsoleStatus.failure:
        return Text(
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageFailure,
          style: defaultStyle?.copyWith(
            color: Theme.of(buildContext).colorScheme.error,
          ),
        );
    }
  }

  List<DataColumn> _buildColumnsFromSolutionRecord(SolutionRecord? record) {
    final columns = <DataColumn>[];

    columns.add(
      DataColumn(
        label: Text(AppLocalizations.of(context)!.codingTableEnergyLabel),
        numeric: true,
      ),
    );

    columns.addAll(
      List<DataColumn>.generate(
        record == null
            ? 0
            : record.entries().first.solutionVector.vector.length,
        (index) => DataColumn(label: Container(), numeric: true),
      ),
    );

    columns.add(
      DataColumn(
        label: Text(AppLocalizations.of(context)!.codingTableFrequencyLabel),
      ),
    );

    return columns;
  }

  List<DataRow> _buildRowsFromSolutionRecord(SolutionRecord record) {
    final rows = <DataRow>[];

    for (var entry in record.entries()) {
      final cells = <DataCell>[];
      final solutionList = entry.solutionVector.vector;

      cells.add(DataCell(Text(entry.energy.toStringAsFixed(1))));
      cells.addAll(
        List<DataCell>.generate(
          solutionList.length,
          (index) => DataCell(Text("${solutionList[index]}")),
        ),
      );
      cells.add(DataCell(Text("×${entry.numOccurrences}")));

      rows.add(DataRow(cells: cells));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final consoleState = context.read<CodingService>().state;

    return BlocListener<CodingService, ConsoleContent>(
      listener: (context, state) => setState(() {}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PartSeparator(
            widget.mode == CodingMode.simulator
                ? AppLocalizations.of(context)!
                    .codingConsoleOutputTitleSimulator
                : AppLocalizations.of(context)!
                    .codingConsoleOutputTitleAnnealer,
            verticalMargin: 20,
          ),
          PanelCard(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMessageForStatus(
                  context,
                  consoleState.status,
                ),
                if (consoleState.status == ConsoleStatus.success)
                  const SizedBox(
                    height: 15,
                  ),
                if (consoleState.status == ConsoleStatus.success)
                  RawScrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thumbColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.7),
                    radius: const Radius.circular(5),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: 0,
                        sortAscending: true,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (_) => Theme.of(context).colorScheme.surface),
                        columns: _buildColumnsFromSolutionRecord(
                            consoleState.record),
                        rows: consoleState.record != null
                            ? _buildRowsFromSolutionRecord(consoleState.record!)
                            : [],
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
