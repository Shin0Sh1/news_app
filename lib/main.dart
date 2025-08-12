import 'package:flutter/material.dart';
import 'package:news_app/theme/app_theme_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData,
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
