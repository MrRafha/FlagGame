import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flag_game/l10n/generated/app_localizations.dart';
import 'package:flag_game/models/game_config.dart';
import 'package:flag_game/models/game_result.dart';
import 'package:flag_game/models/country.dart';
import 'package:flag_game/screens/result_screen.dart';

void main() {
  testWidgets('exibe as estatísticas recebidas da partida', (tester) async {
    final result = GameResult(
      score: 7,
      presentedChallenges: 10,
      correctAnswers: 7,
      incorrectAttempts: 2,
      finishedAt: DateTime(2026, 10, 29),
      mode: GameMode.random,
      duration: Duration(seconds: 60),
      difficulty: Difficulty.easy,
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('pt'),
        home: ResultScreen(result: result),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pontuação: 7'), findsOneWidget);
    expect(find.text('Bandeiras apresentadas: 10'), findsOneWidget);
    expect(find.text('Acertos: 7'), findsOneWidget);
    expect(find.text('Erros: 2'), findsOneWidget);
    expect(find.text('Precisão: 70.0%'), findsOneWidget);
  });
}
