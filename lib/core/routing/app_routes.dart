import 'package:flutter/material.dart';

import '../../models/game_config.dart';
import '../../models/game_result.dart';
import '../../screens/continent_screen.dart';
import '../../screens/game_screen.dart';
import '../../screens/game_setup_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/ranking_screen.dart';
import '../../screens/result_screen.dart';
import '../../screens/settings_screen.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const continent = '/continent';
  static const setup = '/setup';
  static const game = '/game';
  static const result = '/result';
  static const ranking = '/ranking';
  static const settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _page(const HomeScreen());
      case continent:
        return _page(const ContinentScreen());
      case setup:
        final arguments = settings.arguments;
        final setup = arguments is GameSetupArgs
            ? arguments
            : GameSetupArgs(mode: arguments as GameMode? ?? GameMode.random);
        return _page(SetupScreen(mode: setup.mode, continent: setup.continent));
      case game:
        return _page(GameScreen(config: settings.arguments as GameConfig));
      case result:
        final gameResult = settings.arguments;
        return _page(
          ResultScreen(result: gameResult is GameResult ? gameResult : null),
        );
      case ranking:
        return _page(const RankingScreen());
      case AppRoutes.settings:
        return _page(const SettingsScreen());
      default:
        return _page(const HomeScreen());
    }
  }

  static MaterialPageRoute<void> _page(Widget child) {
    return MaterialPageRoute<void>(builder: (_) => child);
  }
}
