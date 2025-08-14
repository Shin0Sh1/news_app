import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/presentation/detaied_news/detailed_news_view.dart';
import 'package:news_app/features/news/presentation/detaied_news/detailed_news_vm.dart';
import 'package:provider/provider.dart';

class DetailedNewsPage extends StatelessWidget {
  final Article article;
  const DetailedNewsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DetailedNewsVm(article: article),
      child: DetailedNewsView(),
    );
  }
}
