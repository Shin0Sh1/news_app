import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/presentation/bottom_nav_bar.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/presentation/detaied_news/detailed_news_page.dart';
import 'package:news_app/features/news/presentation/news_list/news_list_page.dart';
import 'package:news_app/features/news/presentation/selected_news_list/selected_news_page.dart';

class AppRoutes {
  static final _sectionNavigatorNewsListPageKey = GlobalKey<NavigatorState>();
  static final _sectionNavigatorSelectedNewsPageKey =
      GlobalKey<NavigatorState>();

  static const newsListPage = '/news_list';
  static const detailedNewsPage = '/detailed_news_page';
  static const selectedNewsPage = '/selected_news';

  static final routes = GoRouter(
    initialLocation: AppRoutes.newsListPage,
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) => BottomNavBar(navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorNewsListPageKey,
            routes: [
              GoRoute(
                path: AppRoutes.newsListPage,
                builder: (context, state) => const NewsListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorSelectedNewsPageKey,
            routes: [
              GoRoute(
                path: AppRoutes.selectedNewsPage,
                builder: (context, state) => SelectedNewsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.detailedNewsPage,
        builder: (context, state) {
          final article = state.extra as Article;

          return DetailedNewsPage(article: article);
        },
      ),
    ],
  );
}
