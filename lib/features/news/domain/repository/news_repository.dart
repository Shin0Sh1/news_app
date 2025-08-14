import 'package:news_app/features/news/data/models/news_model.dart';

abstract class NewsRepository {
  Future<NewsResponse> getTopHeadlines({
    required String apiKey,
    String? country,
    String? category,
    String? query,
    int? pageSize,
    int? page,
  });
}
