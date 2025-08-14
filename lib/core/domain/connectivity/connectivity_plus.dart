import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.mobile;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService() {
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.isNotEmpty) {
        _connectionStatus = results.first;
        notifyListeners();
      }
    });
  }

  ConnectivityResult get connectionStatus => _connectionStatus;

  bool get isConnected => _connectionStatus != ConnectivityResult.none;

  Future<bool> get isActuallyConnected async {
    if (!isConnected) return false;

    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
