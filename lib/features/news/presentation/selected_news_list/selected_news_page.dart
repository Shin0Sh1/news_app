import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/selected_news_list/selected_news_view.dart';
import 'package:news_app/features/news/presentation/selected_news_list/selected_news_vm.dart';
import 'package:provider/provider.dart';

class SelectedNewsPage extends StatelessWidget {
  const SelectedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => SelectedNewsVm(),
      child: SelectedNewsView(),
    );
  }
}
