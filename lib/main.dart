import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/domain/di/di_container.dart';
import 'package:news_app/core/domain/navigation/app_routes.dart';
import 'package:news_app/features/news/domain/bloc/news_bloc.dart';
import 'package:news_app/theme/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<NewsBloc>(),
      child: MaterialApp.router(
        routerConfig: AppRoutes.routes,
        theme: appThemeData,
      ),
    );
  }
}
