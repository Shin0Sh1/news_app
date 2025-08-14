import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/news_model_hive.dart';

class SelectedNewsVm {
  final Box<HiveArticle> favoritesBox = Hive.box<HiveArticle>('favorites');

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
    isOnline.dispose();
    _connectivitySub?.cancel();
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    isOnline.value = result != ConnectivityResult.none;
  }
}
