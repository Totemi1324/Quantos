enum ContentType {
  paragraph,
  sectionTitle,
  interactive,
  image,
  equation,
}

abstract class ContentItem {
  final ContentType type;
  final String? altText;

  const ContentItem({
    required this.type,
    this.altText,
  });
}
