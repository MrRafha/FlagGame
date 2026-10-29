import 'package:flutter/material.dart';

import '../core/routing/app_routes.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/game_config.dart';
import '../models/game_result.dart';
import '../services/score_service.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});

  final GameResult? result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _scoreService = ScoreService();
  GameResult? _result;
  late Future<void> _saveFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_result != null) return;
    if (widget.result != null) {
      _result = widget.result;
      _saveFuture = _scoreService.saveScore(widget.result!);
    } else {
      _saveFuture = Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.results)),
      body: FutureBuilder<void>(
        future: _saveFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${l10n.mapLoadError} ${snapshot.error}'),
            );
          }
          if (_result == null) {
            return Center(
              child: Text(
                'Não foi possível carregar os dados desta partida.',
                textAlign: TextAlign.center,
              ),
            );
          }
          final result = _result!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${l10n.score}: ${result.score}'),
                  Text('${l10n.presentedFlags}: ${result.presentedChallenges}'),
                  Text('${l10n.correctAnswers}: ${result.correctAnswers}'),
                  Text(
                    '${l10n.incorrectAttempts}: ${result.incorrectAttempts}',
                  ),
                  Text(
                    '${l10n.accuracy}: ${result.accuracy.toStringAsFixed(1)}%',
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.setup,
                      arguments: const GameSetupArgs(mode: GameMode.random),
                    ),
                    child: Text(l10n.playAgain),
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.ranking),
                    child: Text(l10n.viewRanking),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    ),
                    child: Text(l10n.backToMenu),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
