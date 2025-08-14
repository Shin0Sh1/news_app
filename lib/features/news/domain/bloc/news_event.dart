sealed class NewsEvent {}

class GetNewsByCategory extends NewsEvent {
  final String category;
  GetNewsByCategory({required this.category});
}

class SearchNews extends NewsEvent {
  final String query;
  final String category;
  SearchNews({required this.query, required this.category});
}
