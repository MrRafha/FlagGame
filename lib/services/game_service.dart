import 'dart:math';

import '../models/country.dart';
import '../models/game_config.dart';

class GameService {
  List<Country> selectChallenges(
    List<Country> countries,
    GameConfig config, {
    int? seed,
  }) {
    final eligible = countries.where((country) {
      final matchesContinent =
          config.mode == GameMode.random ||
          country.continent == config.continent;
      return matchesContinent && country.difficulty == config.difficulty;
    }).toList();

    eligible.shuffle(seed == null ? null : _SeededRandom(seed));
    return eligible;
  }
}

class _SeededRandom implements Random {
  _SeededRandom(this._seed);

  int _seed;

  @override
  bool nextBool() => nextInt(2) == 1;

  @override
  double nextDouble() => nextInt(1 << 20) / (1 << 20);

  @override
  int nextInt(int max) {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return _seed % max;
  }
}
