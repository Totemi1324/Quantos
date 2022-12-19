import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../../widgets/containers/rounded_card.dart';
import '../../widgets/part_separator.dart';
import '../../widgets/download_list.dart';
import '../../data/download_categories.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "Download Center",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: const RoundedCard(
                fillHeight: false,
                fillWidth: true,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Here, you find helper programs (desktop only) and materials for further reading that didn't make the cut in the final lessons. Happy browsing!",
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: downloadCategories.length,
                itemBuilder: (context, index) {
                  bool show = true;
                  if (Platform.isAndroid || Platform.isIOS) {
                    show = downloadCategories[index].id != "2fT4z";
                  }

                  return show
                      ? Column(
                          children: [
                            PartSeparator(
                              downloadCategories[index].title,
                              verticalMargin: 10,
                            ),
                            DownloadList(downloadCategories[index].id),
                          ],
                        )
                      : Container();
                }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
