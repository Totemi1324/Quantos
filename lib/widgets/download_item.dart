import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'containers/rounded_card.dart';
import '../models/download.dart';

class DownloadItem extends StatelessWidget {
  final String id;
  final String title;
  final DownloadSize downloadSize;
  final FileType fileType;
  final bool hasYourLocale;

  const DownloadItem(
    this.id, {
    required this.title,
    required this.downloadSize,
    required this.fileType,
    required this.hasYourLocale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      fillWidth: true,
      fillHeight: false,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  downloadSize.convertToLocalizedString(context),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "•",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  fileType.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            if (hasYourLocale)
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 10,
                      child: Text(
                        AppLocalizations.of(context)!.downloadAvailableMessage,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
