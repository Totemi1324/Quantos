import 'package:flutter/material.dart';

import '../data/downloads.dart';
import '../models/download.dart';
import '../widgets/containers/panel_card.dart';
import '../widgets/download_item.dart';

class DownloadList extends StatelessWidget {
  final String categoryId;

  const DownloadList(this.categoryId, {super.key});

  List<Download> get _items {
    return downloads
        .where((element) => element.categoryId == categoryId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => PanelCard(
        padding: const EdgeInsets.all(10),
        child: DownloadItem(
          items[index].title,
          size: items[index].size.toString(),
          description: items[index].description,
          fileType: items[index].type.name.toUpperCase(),
          link: items[index].links["EN"]!, //TODO: TEMP
        ),
      ),
    );
  }
}
