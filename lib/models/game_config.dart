import 'country.dart';

enum GameMode { random, continent }

class GameSetupArgs {
  const GameSetupArgs({required this.mode, this.continent});

  final GameMode mode;
  final Continent? continent;
}

class GameConfig {
  const GameConfig({
    required this.mode,
    required this.duration,
    required this.difficulty,
    this.continent,
    this.languageCode = 'pt',
  });

  final GameMode mode;
  final Duration duration;
  final Difficulty difficulty;
  final Continent? continent;
  final String languageCode;
}
