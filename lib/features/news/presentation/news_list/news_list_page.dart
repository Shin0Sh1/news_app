import 'package:flutter/material.dart';
import 'package:news_app/core/domain/di/di_container.dart';
import 'package:news_app/features/news/domain/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/news_list/news_list_view.dart';
import 'package:news_app/features/news/presentation/news_list/news_list_vm.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:
          (context) =>
              NewsListVm(context: context, bloc: getIt.get<NewsBloc>()),
      child: NewsListView(),
    );
  }
}
