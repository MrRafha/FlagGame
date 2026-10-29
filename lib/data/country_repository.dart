import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/country.dart';

class CountryRepository {
  const CountryRepository({AssetBundle? bundle}) : _bundle = bundle;

  final AssetBundle? _bundle;

  Future<List<Country>> loadCountries() async {
    final bundle = _bundle ?? rootBundle;
    final raw = await bundle.loadString('assets/data/countries.json');
    final decoded = jsonDecode(raw);

    if (decoded is! List) {
      throw const FormatException('countries.json precisa conter uma lista.');
    }

    return decoded.map<Country>(_fromJson).toList(growable: false);
  }

  static Country _fromJson(dynamic value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Registro de país inválido.');
    }

    final names = value['name'];
    if (names is! Map) {
      throw const FormatException('País sem nomes localizados.');
    }

    return Country(
      code: value['code'] as String,
      names: names.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      ),
      continent: Continent.values.byName(value['continent'] as String),
      difficulty: Difficulty.values.byName(value['difficulty'] as String),
      flagAsset: value['flagAsset'] as String,
    );
  }
}
