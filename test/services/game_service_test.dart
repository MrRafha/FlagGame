import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/models/country.dart';
import 'package:flag_game/models/game_config.dart';
import 'package:flag_game/services/game_service.dart';

void main() {
  const countries = [
    Country(
      code: 'BR',
      names: {'pt': 'Brasil'},
      continent: Continent.america,
      difficulty: Difficulty.easy,
      flagAsset: 'assets/flags/br.png',
    ),
    Country(
      code: 'JP',
      names: {'pt': 'Japão'},
      continent: Continent.asia,
      difficulty: Difficulty.easy,
      flagAsset: 'assets/flags/jp.png',
    ),
    Country(
      code: 'FR',
      names: {'pt': 'França'},
      continent: Continent.europe,
      difficulty: Difficulty.hard,
      flagAsset: 'assets/flags/fr.png',
    ),
  ];

  test('filtra países por continente e dificuldade', () {
    final service = GameService();
    final selected = service.selectChallenges(
      countries,
      const GameConfig(
        mode: GameMode.continent,
        continent: Continent.america,
        duration: Duration(seconds: 30),
        difficulty: Difficulty.easy,
      ),
    );

    expect(selected.map((country) => country.code), ['BR']);
  });

  test('modo aleatório não inclui dificuldade diferente', () {
    final service = GameService();
    final selected = service.selectChallenges(
      countries,
      const GameConfig(
        mode: GameMode.random,
        duration: Duration(seconds: 30),
        difficulty: Difficulty.easy,
      ),
      seed: 1,
    );

    expect(
      selected.map((country) => country.code),
      containsAll(<String>['BR', 'JP']),
    );
    expect(selected, hasLength(2));
  });
}
