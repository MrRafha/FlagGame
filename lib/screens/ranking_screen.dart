import 'package:flutter/material.dart';

import '../models/country.dart';
import '../models/game_result.dart';
import '../models/game_config.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/score_service.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late Future<List<GameResult>> _scores;

  @override
  void initState() {
    super.initState();
    _scores = ScoreService().loadScores();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.localRanking)),
      body: FutureBuilder<List<GameResult>>(
        future: _scores,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Não foi possível carregar o ranking.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text(l10n.noResults));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final result = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('${result.score} pontos'),
                subtitle: Text(
                  '${result.correctAnswers}/${result.presentedChallenges} acertos · '
                  '${_modeLabel(result)} · ${_durationLabel(result.duration)} · '
                  '${_difficultyLabel(result.difficulty)}',
                ),
                trailing: Text('${result.accuracy.toStringAsFixed(0)}%'),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) return;
    _scores = ScoreService().loadScores();
  }

  String _modeLabel(GameResult result) {
    if (result.mode == GameMode.random) return 'Aleatório';
    return result.continent == null
        ? 'Continente'
        : _continentLabel(result.continent!);
  }

  String _durationLabel(Duration duration) {
    if (duration.inMinutes >= 1) return '${duration.inMinutes} min';
    return '${duration.inSeconds} s';
  }

  String _difficultyLabel(Difficulty difficulty) {
    return difficulty == Difficulty.easy ? 'Fácil' : 'Difícil';
  }

  String _continentLabel(Continent continent) => switch (continent) {
    Continent.africa => 'África',
    Continent.america => 'América',
    Continent.asia => 'Ásia',
    Continent.europe => 'Europa',
    Continent.oceania => 'Oceania',
  };
}
