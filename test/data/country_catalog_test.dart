import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/data/country_repository.dart';
import 'package:flag_game/models/country.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('catálogo inicial cobre todos os continentes', () async {
    final countries = await const CountryRepository().loadCountries();

    for (final continent in Continent.values) {
      expect(
        countries.where((country) => country.continent == continent),
        isNotEmpty,
        reason: 'O catálogo precisa cobrir ${continent.name}.',
      );
    }

    expect(
      countries.map((country) => country.code).toSet(),
      hasLength(countries.length),
    );
    expect(
      countries.every(
        (country) => country.names.values.every((name) => !name.contains('?')),
      ),
      isTrue,
    );
  });
}
