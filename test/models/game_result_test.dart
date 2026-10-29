import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/models/game_result.dart';

void main() {
  test('calcula acurácia sem dividir por zero', () {
    final result = GameResult(
      score: 0,
      presentedChallenges: 0,
      correctAnswers: 0,
      incorrectAttempts: 0,
      finishedAt: DateTime(2026),
    );

    expect(result.accuracy, 0);
  });
}
