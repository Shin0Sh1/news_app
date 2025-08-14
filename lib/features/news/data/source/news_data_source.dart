import 'package:dio/dio.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:retrofit/retrofit.dart';

part 'news_data_source.g.dart';

@RestApi()
abstract class NewsDataSource {
  factory NewsDataSource(Dio dio, {String baseUrl}) = _NewsDataSource;

  @GET("top-headlines")
  Future<HttpResponse<NewsResponse>> getTopHeadlines({
    @Query("apiKey") required String apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
    @Query("q") String? query,
    @Query("pageSize") int? pageSize,
    @Query("page") int? page,
  });
}
