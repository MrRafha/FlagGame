enum Continent { africa, america, asia, europe, oceania }

enum Difficulty { easy, hard }

class Country {
  const Country({
    required this.code,
    required this.names,
    required this.continent,
    required this.difficulty,
    required this.flagAsset,
  });

  final String code;
  final Map<String, String> names;
  final Continent continent;
  final Difficulty difficulty;
  final String flagAsset;

  String nameFor(String languageCode) {
    return names[languageCode] ?? names['pt'] ?? code;
  }
}
