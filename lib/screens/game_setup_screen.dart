import 'package:flutter/material.dart';

import '../core/routing/app_routes.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/country.dart';
import '../models/game_config.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key, this.mode, this.continent});

  final GameMode? mode;
  final Continent? continent;

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  late GameMode _mode = widget.mode ?? GameMode.random;
  late Continent _continent = widget.continent ?? Continent.america;
  Difficulty _difficulty = Difficulty.easy;
  Duration _duration = const Duration(seconds: 60);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.configureGame)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          DropdownButtonFormField<GameMode>(
            initialValue: _mode,
            decoration: InputDecoration(labelText: l10n.gameMode),
            items: [
              DropdownMenuItem(
                value: GameMode.random,
                child: Text(l10n.random),
              ),
              DropdownMenuItem(
                value: GameMode.continent,
                child: Text(l10n.byContinent),
              ),
            ],
            onChanged: (value) => setState(() => _mode = value!),
          ),
          if (_mode == GameMode.continent)
            DropdownButtonFormField<Continent>(
              initialValue: _continent,
              decoration: InputDecoration(labelText: l10n.continent),
              items: Continent.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(_continentLabel(value, l10n)),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _continent = value!),
            ),
          DropdownButtonFormField<Difficulty>(
            initialValue: _difficulty,
            decoration: InputDecoration(labelText: l10n.difficulty),
            items: [
              DropdownMenuItem(value: Difficulty.easy, child: Text(l10n.easy)),
              DropdownMenuItem(value: Difficulty.hard, child: Text(l10n.hard)),
            ],
            onChanged: (value) => setState(() => _difficulty = value!),
          ),
          DropdownButtonFormField<Duration>(
            initialValue: _duration,
            decoration: InputDecoration(labelText: l10n.duration),
            items: [
              DropdownMenuItem(
                value: Duration(seconds: 30),
                child: Text(l10n.seconds30),
              ),
              DropdownMenuItem(
                value: Duration(seconds: 60),
                child: Text(l10n.seconds60),
              ),
              DropdownMenuItem(
                value: Duration(minutes: 3),
                child: Text(l10n.minutes3),
              ),
              DropdownMenuItem(
                value: Duration(minutes: 5),
                child: Text(l10n.minutes5),
              ),
            ],
            onChanged: (value) => setState(() => _duration = value!),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              AppRoutes.game,
              arguments: GameConfig(
                mode: _mode,
                continent: _mode == GameMode.continent ? _continent : null,
                duration: _duration,
                difficulty: _difficulty,
              ),
            ),
            child: Text(l10n.startMatch),
          ),
        ],
      ),
    );
  }

  String _continentLabel(Continent continent, AppLocalizations l10n) =>
      switch (continent) {
        Continent.africa => l10n.africa,
        Continent.america => l10n.america,
        Continent.asia => l10n.asia,
        Continent.europe => l10n.europe,
        Continent.oceania => l10n.oceania,
      };
}
