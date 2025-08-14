import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/domain/navigation/app_routes.dart';
import 'package:news_app/core/presentation/connection_error_widget.dart';
import 'package:news_app/features/news/data/models/news_model_hive.dart';
import 'package:news_app/features/news/presentation/selected_news_list/selected_news_vm.dart';
import 'package:news_app/features/news/presentation/widgets/news_card.dart';

class SelectedNewsView extends StatefulWidget {
  const SelectedNewsView({super.key});

  @override
  State<SelectedNewsView> createState() => _SelectedNewsViewState();
}

class _SelectedNewsViewState extends State<SelectedNewsView> {
  late final _vm = context.read<SelectedNewsVm>();

  @override
  void initState() {
    _vm.initState();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.transparent),
      body: ValueListenableBuilder<bool>(
        valueListenable: _vm.isOnline,
        builder: (context, isOnline, _) {
          if (!isOnline) {
            return ConnectionErrorWidget.build(context: context);
          }

          return ValueListenableBuilder(
            valueListenable: _vm.favoritesBox.listenable(),
            builder: (context, Box<HiveArticle> box, _) {
              final articles = box.values.toList();
              if (articles.isEmpty) {
                return ConnectionErrorWidget.build(
                  context: context,
                  title: 'Нет новостей',
                  subtitle: 'Попробуйте позже или измените категорию',
                  icon: Icons.article_outlined,
                );
              }
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: NewsCard(
                      article: article.toArticle(),
                      isFavorite: true,
                      onTap: (news) {
                        context.push(
                          AppRoutes.detailedNewsPage,
                          extra: article.toArticle(),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
