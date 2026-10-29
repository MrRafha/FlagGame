import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/models/country.dart';
import 'package:flag_game/models/game_config.dart';
import 'package:flag_game/models/game_state.dart';
import 'package:flag_game/data/country_repository.dart';
import 'package:flag_game/services/game_controller.dart';

void main() {
  const countriesJson = '''
[
  {
    "code": "BR",
    "name": {"pt": "Brasil"},
    "continent": "america",
    "difficulty": "easy",
    "flagAsset": "assets/flags/br.svg"
  },
  {
    "code": "AR",
    "name": {"pt": "Argentina"},
    "continent": "america",
    "difficulty": "easy",
    "flagAsset": "assets/flags/ar.svg"
  }
]
''';

  test('avança, pontua e finaliza ao resolver todos os desafios', () async {
    final controller = GameController(
      config: const GameConfig(
        mode: GameMode.random,
        duration: Duration(minutes: 1),
        difficulty: Difficulty.easy,
      ),
      repository: CountryRepository(bundle: _TestBundle(countriesJson)),
    );

    await controller.start();
    expect(controller.state.status, GameStatus.running);
    expect(controller.totalChallenges, 2);
    expect(controller.submit('invalid'), isFalse);
    expect(controller.state.incorrectAttempts, 1);
    expect(controller.submit(controller.state.currentCountry!.code), isTrue);
    expect(controller.state.status, GameStatus.running);
    expect(controller.submit(controller.state.currentCountry!.code), isTrue);
    expect(controller.state.status, GameStatus.finished);
    expect(controller.state.result?.correctAnswers, 2);
    expect(controller.state.result?.presentedChallenges, 2);
    controller.dispose();
  });

  test('não aceita respostas depois da finalização', () async {
    final controller = GameController(
      config: const GameConfig(
        mode: GameMode.random,
        duration: Duration(minutes: 1),
        difficulty: Difficulty.easy,
      ),
      repository: CountryRepository(bundle: _TestBundle(countriesJson)),
    );

    await controller.start();
    final first = controller.state.currentCountry!.code;
    controller.submit(first);
    controller.submit(controller.state.currentCountry!.code);
    final attempts = controller.state.incorrectAttempts;

    expect(controller.submit('BR'), isFalse);
    expect(controller.state.incorrectAttempts, attempts);
    controller.dispose();
  });
}

class _TestBundle extends CachingAssetBundle {
  _TestBundle(this.countriesJson);

  final String countriesJson;

  @override
  Future<ByteData> load(String key) async {
    final bytes = Uint8List.fromList(countriesJson.codeUnits);
    return ByteData.view(bytes.buffer);
  }
}
