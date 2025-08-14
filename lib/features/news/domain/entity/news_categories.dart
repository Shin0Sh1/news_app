enum NewsCategory {
  business('business', 'Business'),
  general('general', 'General'),
  science('science', 'Science'),
  health('health', 'Health'),
  entertainment('entertainment', 'Entertainment'),
  sports('sports', 'Sports'),
  technology('technology', 'Technology');

  final String apiName;
  final String displayName;
  const NewsCategory(this.apiName, this.displayName);

  @override
  String toString() => apiName;
}
