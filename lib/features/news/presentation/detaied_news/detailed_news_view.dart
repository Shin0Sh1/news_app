import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/presentation/assets/svgs.dart';
import 'package:news_app/core/presentation/connection_error_widget.dart';
import 'package:news_app/features/news/presentation/detaied_news/detailed_news_vm.dart';

class DetailedNewsView extends StatefulWidget {
  const DetailedNewsView({super.key});

  @override
  State<DetailedNewsView> createState() => _DetailedNewsViewState();
}

class _DetailedNewsViewState extends State<DetailedNewsView> {
  late final _vm = context.read<DetailedNewsVm>();

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
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(Svgs.arrowBack),
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _vm.isFavoriteNotifier,
            builder: (context, isFav, _) {
              return IconButton(
                icon: SvgPicture.asset(isFav ? Svgs.filledStar : Svgs.star),
                onPressed: _vm.toggleFavorite,
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _vm.isOnline,
        builder: (context, isOnline, child) {
          if (!isOnline) {
            return ConnectionErrorWidget.build(context: context);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                Text(
                  _vm.article.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                if (_vm.article.description != null)
                  Text(
                    _vm.article.description!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _vm.article.source.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      DateFormat('MM.dd.yyyy').format(_vm.article.publishedAt),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (_vm.article.urlToImage != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      _vm.article.urlToImage!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                SizedBox(height: 18),
                if (_vm.article.content != null)
                  Text(
                    _vm.article.content!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
