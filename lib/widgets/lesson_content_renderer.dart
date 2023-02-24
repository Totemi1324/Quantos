import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:tuple/tuple.dart';

import '../bloc/lesson_content_service.dart';

import '../models/content/content_item.dart';
import '../models/content/section_title.dart';
import '../models/content/paragraph.dart';
import '../models/content/interactive.dart';
import '../models/content/image.dart' as image_content;
import '../models/content/equation.dart';

enum NavigationAction {
  next,
  previous,
  skip,
}

class LessonContentRenderer extends StatefulWidget {
  final Stream<Tuple3<BuildContext, NavigationAction, String?>>
      navigationStream;

  const LessonContentRenderer({required this.navigationStream, super.key});

  @override
  State<LessonContentRenderer> createState() => _LessonContentRendererState();
}

class _LessonContentRendererState extends State<LessonContentRenderer>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    value: 1.0,
  );
  late final _fadeAnimation =
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    widget.navigationStream.listen(
      (event) async {
        if (!_checkValidNavigation(event.item1, event.item2)) {
          return;
        }
        await _fadeController.reverse();
        _navigate(event.item1, event.item2, event.item3);
        _scrollController.jumpTo(0);
        _fadeController.forward();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();

    super.dispose();
  }

  bool _checkValidNavigation(
      BuildContext buildContext, NavigationAction action) {
    switch (action) {
      case NavigationAction.next:
        return buildContext
            .read<LessonContentService>()
            .state
            .moveNextIsSafe(_currentPageIndex);
      case NavigationAction.previous:
        return buildContext
            .read<LessonContentService>()
            .state
            .movePreviousIsSafe(_currentPageIndex);
      case NavigationAction.skip:
        return true;
    }
  }

  void _navigate(BuildContext buildContext, NavigationAction action,
      String? sectionTitle) {
    switch (action) {
      case NavigationAction.next:
        setState(() {
          _currentPageIndex++;
        });
        break;
      case NavigationAction.previous:
        setState(() {
          _currentPageIndex--;
        });
        break;
      case NavigationAction.skip:
        if (sectionTitle != null) {
          setState(() {
            _currentPageIndex = buildContext
                .read<LessonContentService>()
                .state
                .indexOfPageWithSectionTitle(sectionTitle);
          });
        }
        break;
    }
  }

  Widget _buildContentItem(BuildContext buildContext, ContentItem item) {
    switch (item.type) {
      case ContentType.paragraph:
        final paragraph = item as Paragraph;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: Theme.of(buildContext).textTheme.bodySmall,
              children: _transformParagraphSpans(
                paragraph.texts,
                Theme.of(buildContext)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      case ContentType.sectionTitle:
        final sectionTitle = item as SectionTitle;
        return Container(
          margin: const EdgeInsets.only(top: 20, bottom: 15),
          child: Text(
            sectionTitle.title,
            style: Theme.of(buildContext).textTheme.titleLarge,
          ),
        );
      case ContentType.interactive:
        final interactive = item as Interactive;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              interactive.content,
              Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: IconButton(
                      onPressed: () {},
                      color: Theme.of(buildContext).colorScheme.secondary,
                      padding: const EdgeInsets.all(2),
                      icon: const Icon(
                        Icons.record_voice_over_rounded,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      interactive.caption,
                      style: Theme.of(buildContext).textTheme.displaySmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      case ContentType.image:
        final image = item as image_content.Image;
        return Container(
          margin:
              const EdgeInsets.only(top: 10, bottom: 25, right: 10, left: 10),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Image.asset(
                  fit: BoxFit.scaleDown,
                  "assets/images/lessons/${image.asset}",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                image.caption,
                textAlign: TextAlign.center,
                style: Theme.of(buildContext).textTheme.displaySmall,
              ),
            ],
          ),
        );
      case ContentType.equation:
        final equation = item as Equation;
        final longTex = Math.tex(
          equation.tex,
          mathStyle: MathStyle.display,
          textStyle:
              TextStyle(color: Theme.of(buildContext).colorScheme.onBackground),
        );
        return Container(
          margin: const EdgeInsets.only(top: 15, bottom: 25),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: longTex.texBreak().parts,
            ),
          ),
        );
    }
  }

  List<InlineSpan> _transformParagraphSpans(
      List<ParagraphSpan> spans, TextStyle? boldStyle) {
    final List<InlineSpan> result = [];

    for (var span in spans) {
      switch (span.type) {
        case ParagraphSpanType.normal:
          result.add(TextSpan(text: span.text));
          break;
        case ParagraphSpanType.bold:
          result.add(TextSpan(text: span.text, style: boldStyle));
          break;
        case ParagraphSpanType.equation:
          result.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                span.text,
                mathStyle: MathStyle.text,
              ),
            ),
          );
          break;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final currentState = context.read<LessonContentService>().state;
    final List<ContentItem> currentContent =
        currentState.content[_currentPageIndex];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: currentContent.length + 1,
          itemBuilder: (context, index) {
            return index < currentContent.length
                ? _buildContentItem(context, currentContent[index])
                : const SizedBox(
                    height: 40,
                  );
          },
        ),
      ),
    );
  }
}
