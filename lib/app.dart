import 'package:flutter/material.dart';
import 'l10n/generated/app_localizations.dart';

import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'services/preferences_service.dart';

class FlagGameApp extends StatefulWidget {
  const FlagGameApp({super.key});

  @override
  State<FlagGameApp> createState() => _FlagGameAppState();
}

class _FlagGameAppState extends State<FlagGameApp> {
  final _preferences = PreferencesService();
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final languageCode = await _preferences.loadLanguage();
    if (mounted) setState(() => _locale = Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Game',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: _locale ?? const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
