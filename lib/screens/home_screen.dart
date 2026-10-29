import 'package:flutter/material.dart';

import '../core/routing/app_routes.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/game_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'flag game.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(l10n.mapReady, textAlign: TextAlign.center),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.continent),
                  child: Text(l10n.startGame),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.setup,
                    arguments: const GameSetupArgs(mode: GameMode.random),
                  ),
                  child: Text(l10n.randomMode),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.ranking),
                  child: Text(l10n.localRanking),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.settings),
                  child: Text(l10n.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
