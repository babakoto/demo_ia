import 'package:flutter/material.dart';
import 'package:fos/fos.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../utils/memory_game_keys.dart';

/// Affiche l'echec de chargement d'un niveau et propose de reessayer.
class MemoryErrorView extends StatelessWidget {
  const MemoryErrorView({
    super.key,
    required this.failure,
    required this.onRetry,
  });

  final Failure? failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      key: MemoryGameKeys.boardError,
      child: Padding(
        padding: const .all(24),
        child: Column(
          mainAxisSize: .min,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(AppStrings.errorTitle, style: theme.textTheme.titleMedium),
            if (failure?.message != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                failure!.message!,
                textAlign: .center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
