import 'package:bloc/bloc.dart';
import 'package:news_app/features/news/data/source/news_data_source.dart';
import 'package:news_app/features/news/domain/bloc/news_event.dart';
import 'package:news_app/features/news/domain/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsDataSource api;
  final String defaultCountry;
  final String apiKey;

  NewsBloc({
    required this.api,
    this.defaultCountry = 'us',
    required this.apiKey,
  }) : super(NewsInitial()) {
    on<GetNewsByCategory>(_getNewsByCategory);
    on<SearchNews>((event, emit) {
      if (state is NewsLoaded) {
        final loadedState = state as NewsLoaded;
        final filtered =
            loadedState.articles.where((a) {
              final title = a.title.toLowerCase();
              final author = (a.author ?? '').toLowerCase();
              return title.contains(event.query.toLowerCase()) ||
                  author.contains(event.query.toLowerCase());
            }).toList();
        emit(NewsLoaded(articles: filtered, category: event.category));
      }
    });
  }

  Future<void> _getNewsByCategory(
    GetNewsByCategory event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final response = await api.getTopHeadlines(
        apiKey: apiKey,
        country: defaultCountry,
        category: event.category,
        pageSize: 20,
        page: 1,
      );
      emit(
        NewsLoaded(articles: response.data.articles, category: event.category),
      );
    } catch (e) {
      emit(NewsError('Не удалось загрузить новости: $e'));
    }
  }
}
