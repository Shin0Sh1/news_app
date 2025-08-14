import 'package:news_app/features/news/data/models/news_model.dart';

sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final String category;
  NewsLoaded({required this.articles, required this.category});
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
