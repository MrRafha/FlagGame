import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/map/country_hit_tester.dart';

void main() {
  const tester = CountryHitTester();
  final paths = {
    'BR': Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100)),
    'UY': Path()..addRect(const Rect.fromLTWH(105, 40, 8, 8)),
  };

  test('prioriza o polígono exato', () {
    expect(
      tester.hitTest(
        position: const Offset(50, 50),
        paths: paths,
        interactiveCodes: paths.keys.toSet(),
      ),
      'BR',
    );
  });

  test('tolera pequena margem para países pequenos', () {
    expect(
      tester.hitTest(
        position: const Offset(104, 44),
        paths: paths,
        interactiveCodes: paths.keys.toSet(),
      ),
      'UY',
    );
  });

  test('ignora países não interativos', () {
    expect(
      tester.hitTest(
        position: const Offset(50, 50),
        paths: paths,
        interactiveCodes: {'UY'},
      ),
      isNull,
    );
  });
}
