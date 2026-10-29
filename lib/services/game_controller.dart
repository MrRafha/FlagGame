import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/country_repository.dart';
import '../models/country.dart';
import '../models/game_config.dart';
import '../models/game_result.dart';
import '../models/game_state.dart';
import '../map/map_definition.dart';
import 'game_service.dart';

class GameController extends ChangeNotifier {
  GameController({
    required GameConfig config,
    CountryRepository? repository,
    GameService? service,
  }) : _config = config,
       _repository = repository ?? const CountryRepository(),
       _service = service ?? GameService();

  final GameConfig _config;
  final CountryRepository _repository;
  final GameService _service;
  Timer? _timer;
  List<Country> _countries = const [];
  List<Country> _challenges = const [];
  int _currentIndex = 0;
  int _presentedChallenges = 0;
  int _runId = 0;
  Duration _remaining = Duration.zero;
  GameState _state = const GameState(status: GameStatus.ready);

  GameConfig get config => _config;
  GameState get state => _state;
  Duration get remaining => _remaining;
  int get totalChallenges => _challenges.length;
  Map<String, String> get flagAssets => {
    for (final country in _challenges) country.code: country.flagAsset,
  };
  Map<String, String> get countryNames => {
    for (final country in _countries.where(
      (country) =>
          _config.mode == GameMode.random ||
          country.continent == _config.continent,
    ))
      country.code: country.nameFor(_config.languageCode),
  };
  Set<String> get mapCountryCodes => _countries
      .where(
        (country) =>
            _config.mode == GameMode.random ||
            country.continent == _config.continent,
      )
      .map((country) => country.code)
      .toSet();
  MapDefinition get mapDefinition => MapDefinition.forContinent(
    _config.mode == GameMode.continent ? _config.continent : null,
  );

  Future<void> start() async {
    final runId = ++_runId;
    _timer?.cancel();
    _state = const GameState(status: GameStatus.ready);
    notifyListeners();
    final countries = await _repository.loadCountries();
    if (runId != _runId) return;
    _countries = countries;
    _challenges = _service.selectChallenges(countries, _config);
    _currentIndex = 0;
    _presentedChallenges = 0;
    _remaining = _config.duration;

    if (_challenges.isEmpty) {
      _finish();
      return;
    }

    _state = GameState(
      status: GameStatus.running,
      currentCountry: _challenges.first,
    );
    _presentedChallenges = 1;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  bool submit(String countryCode) {
    if (_state.status != GameStatus.running || _state.currentCountry == null) {
      return false;
    }

    if (countryCode != _state.currentCountry!.code ||
        _state.resolvedCountries.contains(countryCode)) {
      _state = GameState(
        status: _state.status,
        currentCountry: _state.currentCountry,
        resolvedCountries: _state.resolvedCountries,
        score: _state.score,
        incorrectAttempts: _state.incorrectAttempts + 1,
      );
      notifyListeners();
      return false;
    }

    final resolved = {..._state.resolvedCountries, countryCode};
    final score = _state.score + 1;
    _currentIndex++;
    if (_currentIndex >= _challenges.length) {
      _state = GameState(
        status: GameStatus.finished,
        resolvedCountries: resolved,
        score: score,
        incorrectAttempts: _state.incorrectAttempts,
        result: _result(score, resolved.length, _state.incorrectAttempts),
      );
      _timer?.cancel();
    } else {
      _presentedChallenges++;
      _state = GameState(
        status: GameStatus.running,
        currentCountry: _challenges[_currentIndex],
        resolvedCountries: resolved,
        score: score,
        incorrectAttempts: _state.incorrectAttempts,
      );
    }
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    if (_state.status != GameStatus.running) {
      return;
    }
    if (_remaining <= const Duration(seconds: 1)) {
      _remaining = Duration.zero;
      _finish();
      return;
    }
    _remaining -= const Duration(seconds: 1);
    notifyListeners();
  }

  void _finish() {
    if (_state.status == GameStatus.finished) return;
    _timer?.cancel();
    _state = GameState(
      status: GameStatus.finished,
      currentCountry: _state.currentCountry,
      resolvedCountries: _state.resolvedCountries,
      score: _state.score,
      incorrectAttempts: _state.incorrectAttempts,
      result: _result(
        _state.score,
        _state.resolvedCountries.length,
        _state.incorrectAttempts,
      ),
    );
    notifyListeners();
  }

  GameResult _result(int score, int correct, int incorrect) {
    return GameResult(
      score: score,
      presentedChallenges: _presentedChallenges,
      correctAnswers: correct,
      incorrectAttempts: incorrect,
      finishedAt: DateTime.now(),
      mode: _config.mode,
      continent: _config.continent,
      duration: _config.duration,
      difficulty: _config.difficulty,
    );
  }
}
