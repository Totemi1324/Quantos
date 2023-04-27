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
  int _sortColumnIndex = 0;
  bool _isAscending = true;

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
          onSort: _onSort),
    );

    columns.addAll(
      List<DataColumn>.generate(
        record == null
            ? 0
            : record.entries().first.solutionVector.vector.length,
        (index) =>
            DataColumn(label: Container(), numeric: true, onSort: _onSort),
      ),
    );

    columns.add(
      DataColumn(
          label: Text(AppLocalizations.of(context)!.codingTableFrequencyLabel),
          onSort: _onSort),
    );

    return columns;
  }

  List<DataRow> _buildRowsFromSolutionRecordEntries(
      Iterable<SolutionRecordEntry> recordEntries) {
    final rows = <DataRow>[];

    for (var entry in recordEntries) {
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

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;
    });
  }

  Iterable<SolutionRecordEntry> _sort(Iterable<SolutionRecordEntry> entries) {
    final vectorLength = entries.first.solutionVector.vector.length;
    compareNumbers(num1, num2) =>
        _isAscending ? num1.compareTo(num2) : num2.compareTo(num1);

    final entryList = entries.toList();

    if (_sortColumnIndex == 0) {
      entryList.sort(
        (a, b) => compareNumbers(a.energy, b.energy),
      );
    } else if (_sortColumnIndex > 0 && _sortColumnIndex <= vectorLength) {
      entryList.sort(
        (a, b) => compareNumbers(
          a.solutionVector.vector[_sortColumnIndex - 1],
          b.solutionVector.vector[_sortColumnIndex - 1],
        ),
      );
    } else if (_sortColumnIndex == vectorLength + 1) {
      entryList.sort(
        (a, b) => compareNumbers(a.numOccurrences, b.numOccurrences),
      );
    }

    return entryList;
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
                if (consoleState.status == ConsoleStatus.success ||
                    consoleState.status == ConsoleStatus.failure)
                  const SizedBox(
                    height: 15,
                  ),
                if (consoleState.status == ConsoleStatus.failure)
                  Text(consoleState.errorMessage ?? ""),
                if (consoleState.status == ConsoleStatus.success)
                  RawScrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thumbColor: Colors.white.withOpacity(0.3),
                    radius: const Radius.circular(5),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _isAscending,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (_) => Theme.of(context).colorScheme.surface),
                        columns: _buildColumnsFromSolutionRecord(
                            consoleState.record),
                        rows: consoleState.record != null
                            ? _buildRowsFromSolutionRecordEntries(
                                _sort(consoleState.record!.entries()),
                              )
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
