import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/map/map_definition.dart';

void main() {
  test('mapa mundial possui identificação própria para ocultar rótulos', () {
    expect(MapDefinition.world.name, 'world');
  });

  test('mapas continentais permanecem identificados', () {
    expect(MapDefinition.europe.name, 'europe');
    expect(MapDefinition.africa.name, 'africa');
  });
}
