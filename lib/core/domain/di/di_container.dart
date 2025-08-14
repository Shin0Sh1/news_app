import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/domain/enviroment/env.dart';
import 'package:news_app/core/domain/navigation/app_routes.dart';
import 'package:news_app/features/news/data/models/news_model_hive.dart';
import 'package:news_app/features/news/data/source/news_data_source.dart';
import 'package:news_app/features/news/domain/bloc/news_bloc.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';
import 'package:news_app/features/news/domain/repository/news_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  GoRouter initRouter() => AppRoutes.routes;
  getIt.registerSingleton(initRouter());

  final baseUrl = Env.baseUrl;
  final apiKey = Env.apiKey;

  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  getIt.registerSingleton<NewsDataSource>(NewsDataSource(dio));

  getIt.registerSingleton<NewsRepository>(
    NewsRepositoryImpl(newsDataSource: getIt.get<NewsDataSource>()),
  );

  getIt.registerSingleton<NewsBloc>(
    NewsBloc(api: getIt.get<NewsDataSource>(), apiKey: apiKey),
  );

  await Hive.initFlutter();

  Hive.registerAdapter(HiveSourceAdapter());
  Hive.registerAdapter(HiveArticleAdapter());

  await Hive.openBox<HiveArticle>('favorites');
}
