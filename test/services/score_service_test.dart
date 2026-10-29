import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flag_game/models/game_result.dart';
import 'package:flag_game/services/score_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('salva e ordena os dez melhores resultados', () async {
    final service = ScoreService();
    for (var score = 1; score <= 11; score++) {
      await service.saveScore(
        GameResult(
          score: score,
          presentedChallenges: 5,
          correctAnswers: score > 5 ? 5 : score,
          incorrectAttempts: 0,
          finishedAt: DateTime(2026, 1, score),
        ),
      );
    }

    final scores = await service.loadScores();
    expect(scores, hasLength(10));
    expect(scores.first.score, 11);
    expect(scores.last.score, 2);
  });

  test('ignora registros corrompidos', () async {
    SharedPreferences.setMockInitialValues({
      'scores': ['not-json'],
    });

    expect(await ScoreService().loadScores(), isEmpty);
  });

  test('ignora registros com contexto inválido', () async {
    SharedPreferences.setMockInitialValues({
      'scores': [
        '{"score":10,"presented":1,"correct":1,"incorrect":0,'
            '"finishedAt":"2026-01-01T00:00:00.000",'
            '"mode":"invalid","difficulty":"easy"}',
      ],
    });

    expect(await ScoreService().loadScores(), isEmpty);
  });
}
