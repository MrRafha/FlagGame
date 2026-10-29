import 'package:flutter/material.dart';

import '../core/routing/app_routes.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/country.dart';
import '../models/game_config.dart';

class ContinentScreen extends StatelessWidget {
  const ContinentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.chooseContinent)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: Continent.values
            .map(
              (continent) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.setup,
                    arguments: GameSetupArgs(
                      mode: GameMode.continent,
                      continent: continent,
                    ),
                  ),
                  child: Text(_label(continent, l10n)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _label(Continent continent, AppLocalizations l10n) =>
      switch (continent) {
        Continent.africa => l10n.africa,
        Continent.america => l10n.america,
        Continent.asia => l10n.asia,
        Continent.europe => l10n.europe,
        Continent.oceania => l10n.oceania,
      };
}
