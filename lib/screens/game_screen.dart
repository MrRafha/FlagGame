import 'package:flutter/material.dart';

import '../core/routing/app_routes.dart';
import '../l10n/generated/app_localizations.dart';
import '../map/interactive_map.dart';
import '../models/game_config.dart';
import '../models/game_state.dart';
import '../services/game_controller.dart';
import '../widgets/current_flag_card.dart';
import '../widgets/game_header.dart';
import '../widgets/game_timer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.config});

  final GameConfig config;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _controller;
  String? _feedback;
  bool? _feedbackCorrect;
  bool _resultOpened = false;

  @override
  void initState() {
    super.initState();
    _controller = GameController(config: widget.config)
      ..addListener(_onStateChanged)
      ..start();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onStateChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = _controller.state;
    if (state.status == GameStatus.finished &&
        state.result != null &&
        !_resultOpened) {
      _resultOpened = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.result,
            arguments: state.result,
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.game)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GameHeader(
                        score: state.score,
                        progress:
                            '${state.resolvedCountries.length}/${_controller.totalChallenges}',
                      ),
                    ),
                    const SizedBox(width: 16),
                    GameTimer(remaining: _controller.remaining),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.dragInstruction,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF60716D),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            if (state.currentCountry != null)
              CurrentFlagCard(
                flagAsset: state.currentCountry!.flagAsset,
                countryCode: state.currentCountry!.code,
              ),
            const SizedBox(height: 14),
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: InteractiveMap(
                  onCountrySelected: _submit,
                  resolvedCodes: state.resolvedCountries,
                  mapDefinition: _controller.mapDefinition,
                  interactiveCodes: _controller.mapCountryCodes,
                  labels: _controller.mapDefinition.name == 'world'
                      ? const {}
                      : _controller.countryNames,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_feedback != null)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Container(
                  key: ValueKey(_feedback),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _feedbackCorrect == true
                        ? const Color(0xFFE2F2E5)
                        : const Color(0xFFFBE4E1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _feedback!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _feedbackCorrect == true
                          ? const Color(0xFF27643B)
                          : const Color(0xFF9B3D36),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _submit(String code) {
    final correct = _controller.submit(code);
    setState(() {
      _feedbackCorrect = correct;
      final l10n = AppLocalizations.of(context)!;
      _feedback = correct ? l10n.correct : l10n.tryAgain;
    });
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }
}
