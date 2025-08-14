import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/data/models/news_model_hive.dart';

class DetailedNewsVm {
  final HiveArticle article;
  final Box<HiveArticle> _favoritesBox = Hive.box<HiveArticle>('favorites');

  late ValueNotifier<bool> isFavoriteNotifier;

  DetailedNewsVm({required Article article})
    : article = HiveArticleFromArticle.fromArticle(article) {
    isFavoriteNotifier = ValueNotifier(isFavorite);
  }

  bool get isFavorite => _favoritesBox.values.any((a) => a.url == article.url);

  final ValueNotifier<bool> isOnline = ValueNotifier(true);
  late final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  void initState() {
    _connectivity = Connectivity();

    _checkConnectivity();

    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      final result =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
      final online = result != ConnectivityResult.none;
      if (isOnline.value != online) {
        isOnline.value = online;
      }
    });
  }

  void dispose() {
    isFavoriteNotifier.dispose();
    isOnline.dispose();
    _connectivitySub?.cancel();
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    isOnline.value = result != ConnectivityResult.none;
  }

  void toggleFavorite() {
    if (isFavorite) {
      final key = _favoritesBox.keys.firstWhere(
        (k) => _favoritesBox.get(k)!.url == article.url,
      );
      _favoritesBox.delete(key);
    } else {
      _favoritesBox.add(article);
    }
    isFavoriteNotifier.value = isFavorite;
  }
}
