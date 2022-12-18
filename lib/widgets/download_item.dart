import 'package:flutter/material.dart';

import './ui/adaptive_download_button.dart';

class DownloadItem extends StatelessWidget {
  final String title;
  final String size;
  final String description;
  final String fileType;
  final String link;

  const DownloadItem(
    this.title, {
    required this.size,
    required this.description,
    required this.fileType,
    required this.link,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.center,
                child: const Text("•"),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                "$size, $fileType",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: Text(
                description,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: AdaptiveDownloadButton(link),
            )
          ],
        )
      ],
    );
  }
}
