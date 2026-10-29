import 'game_config.dart';
import 'country.dart';

class GameResult {
  const GameResult({
    required this.score,
    required this.presentedChallenges,
    required this.correctAnswers,
    required this.incorrectAttempts,
    required this.finishedAt,
    this.mode = GameMode.random,
    this.continent,
    this.duration = Duration.zero,
    this.difficulty = Difficulty.easy,
  });

  final int score;
  final int presentedChallenges;
  final int correctAnswers;
  final int incorrectAttempts;
  final DateTime finishedAt;
  final GameMode mode;
  final Continent? continent;
  final Duration duration;
  final Difficulty difficulty;

  double get accuracy =>
      presentedChallenges == 0 ? 0 : correctAnswers / presentedChallenges * 100;
}
