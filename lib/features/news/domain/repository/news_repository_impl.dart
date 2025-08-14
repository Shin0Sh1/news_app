import 'package:dio/dio.dart';
import 'package:news_app/core/domain/exception/news_fetch_exception.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/data/source/news_data_source.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsDataSource _newsDataSource;

  NewsRepositoryImpl({required NewsDataSource newsDataSource})
    : _newsDataSource = newsDataSource;

  @override
  Future<NewsResponse> getTopHeadlines({
    required String apiKey,
    String? country,
    String? category,
    String? query,
    int? pageSize,
    int? page,
  }) async {
    try {
      final response = await _newsDataSource.getTopHeadlines(
        apiKey: apiKey,
        country: country,
        category: category,
        query: query,
        pageSize: pageSize,
        page: page,
      );

      final http = response.response;
      final data = response.data;

      final statusCode = http.statusCode;

      if (statusCode != null && statusCode >= 200 && statusCode < 300) {
        return data;
      } else {
        throw NewsFetchException(
          message: 'Unexpected status code',
          statusCode: statusCode,
          details: http.statusMessage,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw NewsFetchException(
          message: 'Request failed: ${e.response?.statusMessage}',
          statusCode: e.response?.statusCode,
          details: e.response?.data,
        );
      } else {
        throw NewsFetchException(
          message: 'Connection error: ${e.message}',
          details: e.error,
        );
      }
    } catch (e) {
      throw NewsFetchException(message: 'Unhandled exception', details: e);
    }
  }
}
