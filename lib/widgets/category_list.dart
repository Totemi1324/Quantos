import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/download_service.dart';

import '../models/download_store.dart';
import './part_separator.dart';
import './download_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final categories = context.read<DownloadService>().state.categories;
    final currentPlatform = context.read<DownloadService>().currentPlatform;

    return BlocListener<DownloadService, DownloadStore>(
      listener: (context, state) => setState(() {}),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return category.availableOn.contains(currentPlatform) &&
                  category.title != ""
              ? Column(
                  children: [
                    PartSeparator(
                      category.title,
                      verticalMargin: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DownloadList(category.id),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
