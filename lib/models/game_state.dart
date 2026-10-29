import 'country.dart';
import 'game_result.dart';

enum GameStatus { ready, running, finished }

class GameState {
  const GameState({
    required this.status,
    this.currentCountry,
    this.resolvedCountries = const <String>{},
    this.score = 0,
    this.incorrectAttempts = 0,
    this.result,
  });

  final GameStatus status;
  final Country? currentCountry;
  final Set<String> resolvedCountries;
  final int score;
  final int incorrectAttempts;
  final GameResult? result;
}
