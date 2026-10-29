import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_config.dart';
import '../models/game_result.dart';
import '../models/country.dart';

class ScoreService {
  static const _scoresKey = 'scores';

  Future<List<GameResult>> loadScores() async {
    final preferences = await SharedPreferences.getInstance();
    final values = preferences.getStringList(_scoresKey) ?? <String>[];
    final scores = <GameResult>[];
    for (final value in values) {
      try {
        scores.add(_decode(value));
      } on FormatException {
        continue;
      } on TypeError {
        continue;
      } on ArgumentError {
        continue;
      }
    }
    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores.take(10).toList(growable: false);
  }

  Future<void> saveScore(GameResult result) async {
    final preferences = await SharedPreferences.getInstance();
    final values = preferences.getStringList(_scoresKey) ?? <String>[];
    values.add(_encode(result));
    final scores = values.map(_tryDecode).whereType<GameResult>().toList()
      ..sort((a, b) => b.score.compareTo(a.score));
    await preferences.setStringList(
      _scoresKey,
      scores.take(10).map(_encode).toList(growable: false),
    );
  }

  String _encode(GameResult result) => jsonEncode({
    'score': result.score,
    'presented': result.presentedChallenges,
    'correct': result.correctAnswers,
    'incorrect': result.incorrectAttempts,
    'finishedAt': result.finishedAt.toIso8601String(),
    'mode': result.mode.name,
    'continent': result.continent?.name,
    'duration': result.duration.inSeconds,
    'difficulty': result.difficulty.name,
  });

  GameResult _decode(String value) {
    final json = jsonDecode(value);
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Resultado inválido.');
    }
    return GameResult(
      score: json['score'] as int,
      presentedChallenges: json['presented'] as int,
      correctAnswers: json['correct'] as int,
      incorrectAttempts: json['incorrect'] as int,
      finishedAt: DateTime.parse(json['finishedAt'] as String),
      mode: GameMode.values.byName(json['mode'] as String? ?? 'random'),
      continent: (json['continent'] as String?) == null
          ? null
          : Continent.values.byName(json['continent'] as String),
      duration: Duration(seconds: json['duration'] as int? ?? 0),
      difficulty: Difficulty.values.byName(
        json['difficulty'] as String? ?? 'easy',
      ),
    );
  }

  GameResult? _tryDecode(String value) {
    try {
      return _decode(value);
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    } on ArgumentError {
      return null;
    }
  }
}
