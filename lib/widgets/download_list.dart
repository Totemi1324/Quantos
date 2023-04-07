import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/download_service.dart';
import '../bloc/localization_service.dart';

import '../widgets/download_item.dart';
import '../models/download.dart';

class DownloadList extends StatefulWidget {
  final String categoryId;

  const DownloadList(this.categoryId, {super.key});

  @override
  State<DownloadList> createState() => _DownloadListState();
}

class _DownloadListState extends State<DownloadList> {
  Widget _buildDownloadItem(
          BuildContext buildContext, Locale currentLocale, Download item) =>
      InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 135),
            child: DownloadItem(
              item.id,
              title: item.title,
              downloadSize: item.size,
              fileType: item.type,
              hasYourLocale: item.links.keys
                  .map((code) => code.toLowerCase())
                  .contains(currentLocale.languageCode),
            ),
          ),
        ),
      );

  List<Download> _filterDownloads(
      BuildContext buildContext, List<Download> downloads) {
    final currentPlatform =
        buildContext.read<DownloadService>().currentPlatform;

    return downloads
        .where((download) => download.availableOn.contains(currentPlatform))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = context
        .read<DownloadService>()
        .state
        .getDownloadsForCategory(widget.categoryId);
    final currentLocale = context.read<LocalizationService>().state;

    return BlocListener<LocalizationService, Locale>(
      listener: (context, state) => setState(() {}),
      child: StaggeredGrid.extent(
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 20,
        children: _filterDownloads(context, items)
            .map<Widget>(
              (item) => StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _buildDownloadItem(
                  context,
                  currentLocale,
                  item,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
