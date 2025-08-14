import 'package:flutter/material.dart';

class ConnectionErrorWidget {
  static Widget build({
    required BuildContext context,
    String? title,
    String? subtitle,
    IconData icon = Icons.wifi_off_rounded,
  }) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 96,
              color: theme.colorScheme.primary.withOpacity(0.8),
            ),
            const SizedBox(height: 24),
            Text(
              title ?? 'Нет подключения к интернету',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle ?? 'Проверьте соединение и попробуйте снова',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
