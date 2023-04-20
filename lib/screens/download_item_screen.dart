import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/download_service.dart';

import './base/decorated.dart';
import '../widgets/containers/panel_card.dart';
import '../widgets/error_page_content.dart';
import '../models/download.dart';

class DownloadItemScreen extends StatefulWidget {
  static const routeName = "/home/download";
  final Map<FileType, IconData> iconForFileType = const {
    FileType.pdf: Icons.description_rounded,
    FileType.json: Icons.data_object_rounded,
    FileType.ipynb: Icons.code_rounded,
    FileType.exe: Icons.terminal_rounded,
  };

  const DownloadItemScreen({super.key});

  @override
  State<DownloadItemScreen> createState() => _DownloadItemScreenState();
}

class _DownloadItemScreenState extends State<DownloadItemScreen> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final downloadId = args as String;
    final download =
        context.read<DownloadService>().state.getDownloadById(downloadId);
    if (download != null && _selected == null) {
      _selected = download.locales.first;
    }

    return download == null
        ? const ErrorPageContent()
        : Decorated(
            showSettings: false,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PanelCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          download.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                download.size.convertToLocalizedString(context),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "•",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  widget.iconForFileType[download.type],
                                ),
                              ),
                              Text(
                                download.type.name.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          download.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        if (_selected != "")
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 25),
                            width: double.infinity,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .downloadSelectLocaleTitle,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        if (_selected != "")
                          GridView.extent(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 10,
                            children: download.locales
                                .map<Widget>(
                                  (locale) => OutlinedButton(
                                    onPressed: () => setState(() {
                                      _selected = locale;
                                    }),
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                        BorderSide(
                                          color: locale == _selected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      locale,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 200,
                        child: GestureDetector(
                          onTapUp: (_) async {
                            await Future.delayed(const Duration(seconds: 3));

                            final downloadLink = Uri.tryParse(
                              download.linkForLocale(_selected ?? "") ?? "",
                            );
                            if (downloadLink != null && await canLaunchUrl(downloadLink)) {
                              await launchUrl(downloadLink);
                            }
                          },
                          child: RiveAnimation.asset(
                            Assets.animations.downloadButton,
                            fit: BoxFit.contain,
                            stateMachines: const ["ListenForPress"],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
