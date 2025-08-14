import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/domain/navigation/app_routes.dart';
import 'package:news_app/core/presentation/assets/svgs.dart';
import 'package:news_app/core/presentation/connection_error_widget.dart';
import 'package:news_app/features/news/domain/bloc/news_bloc.dart';
import 'package:news_app/features/news/domain/bloc/news_state.dart';
import 'package:news_app/features/news/domain/entity/news_categories.dart';
import 'package:news_app/features/news/presentation/news_list/news_list_vm.dart';
import 'package:news_app/features/news/presentation/widgets/news_card.dart';
import 'package:news_app/theme/app_colors.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  late final _vm = context.read<NewsListVm>();

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<bool>(
          valueListenable: _vm.isSearchMode,
          builder: (context, isSearch, _) {
            return NewsAppBar(
              isSearchMode: isSearch,
              searchController: _vm.searchController,
              onSearchChanged: _vm.onSearchChanged,
              onClear: () {
                _vm.clearSearch();
                _vm.toggleSearchMode(false);
              },
              onEnableSearch: () => _vm.toggleSearchMode(true),
              onDisableSearch: () => _vm.toggleSearchMode(false),
            );
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _vm.isOnline,
        builder: (context, isOnline, child) {
          if (!isOnline) {
            return ConnectionErrorWidget.build(context: context);
          }
          return Column(
            children: [
              ValueListenableBuilder<NewsCategory>(
                valueListenable: _vm.selectedCategoryNotifier,
                builder: (context, selectedCategory, _) {
                  return SizedBox(
                    height: 60,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 19),
                      scrollDirection: Axis.horizontal,
                      children:
                          NewsCategory.values.map((category) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                              ),
                              child: ChoiceChip(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                                label: Text(category.displayName),
                                selected: selectedCategory == category,
                                onSelected: (selected) {
                                  if (selected) {
                                    _vm.selectedCategoryNotifier.value =
                                        category;
                                    _vm.getNewsByCategory(
                                      category: category.apiName,
                                    );
                                  }
                                },
                                showCheckmark: false,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                backgroundColor: AppColors.inactiveFilter,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                                side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsInitial || state is NewsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is NewsLoaded) {
                      final articles = state.articles;
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
                              article: article,
                              onTap: (news) {
                                context.push(
                                  AppRoutes.detailedNewsPage,
                                  extra: article,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }

                    if (state is NewsError) {
                      return ConnectionErrorWidget.build(
                        context: context,
                        title: 'Ошибка сервера',
                        subtitle: state.message,
                        icon: Icons.error_outline,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchMode;
  final TextEditingController searchController;
  final VoidCallback onClear;
  final VoidCallback onEnableSearch;
  final VoidCallback onDisableSearch;
  final ValueChanged<String> onSearchChanged;

  const NewsAppBar({
    super.key,
    required this.isSearchMode,
    required this.searchController,
    required this.onClear,
    required this.onEnableSearch,
    required this.onDisableSearch,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title:
          isSearchMode
              ? SizedBox(
                height: 40,
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onClear,
                    ),
                  ),
                  onTapOutside: (_) => onDisableSearch(),
                ),
              )
              : null,
      leading: IconButton(
        icon: SvgPicture.asset(Svgs.search),
        onPressed: onEnableSearch,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
