import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/bloc/news_bloc.dart';
import 'package:news_app/features/news/domain/bloc/news_event.dart';
import 'package:news_app/features/news/domain/entity/news_categories.dart';
import 'package:provider/provider.dart';

class NewsListVm {
  final NewsBloc bloc;
  final BuildContext context;

  NewsListVm({required this.bloc, required this.context});

  final selectedCategoryNotifier = ValueNotifier<NewsCategory>(
    NewsCategory.business,
  );

  final isSearchMode = ValueNotifier<bool>(false);
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  Timer? _debounce;

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

    getNewsByCategory(category: selectedCategoryNotifier.value.apiName);
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    isOnline.value = result != ConnectivityResult.none;
  }

  void getNewsByCategory({required String category}) =>
      context.read<NewsBloc>().add(GetNewsByCategory(category: category));

  void toggleSearchMode(bool enabled) {
    isSearchMode.value = enabled;
    if (!enabled) {
      searchController.clear();
      context.read<NewsBloc>().add(
        GetNewsByCategory(category: selectedCategoryNotifier.value.apiName),
      );
    } else {
      searchFocusNode.requestFocus();
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      context.read<NewsBloc>().add(
        GetNewsByCategory(category: selectedCategoryNotifier.value.apiName),
      );
    } else {
      _debounce = Timer(const Duration(milliseconds: 1500), () {
        context.read<NewsBloc>().add(
          SearchNews(
            query: query,
            category: selectedCategoryNotifier.value.apiName,
          ),
        );
      });
    }
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged('');
  }

  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    searchFocusNode.dispose();
    _connectivitySub?.cancel();
  }
}
