import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/presentation/assets/svgs.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/theme/app_colors.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final void Function(Article news)? onTap;
  final bool isFavorite;

  const NewsCard({
    super.key,
    required this.article,
    this.onTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(article),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 19),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondaryContainer.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.border.withOpacity(0.9),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: Text(
                                article.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (isFavorite)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SvgPicture.asset(Svgs.filledStar),
                            ),
                        ],
                      ),
                      if (article.description != null) ...[
                        const SizedBox(height: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 60),
                          child: Text(
                            article.description!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('MM.dd.yyyy').format(article.publishedAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
