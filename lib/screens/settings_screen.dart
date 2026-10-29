import 'package:flutter/material.dart';

import '../services/preferences_service.dart';
import '../l10n/generated/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _preferences = PreferencesService();
  String _language = 'pt';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final language = await _preferences.loadLanguage();
    if (mounted) setState(() => _language = language);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: DropdownButtonFormField<String>(
          initialValue: _language,
          decoration: InputDecoration(labelText: l10n.language),
          items: [
            DropdownMenuItem(value: 'pt', child: Text(l10n.portuguese)),
            DropdownMenuItem(value: 'en', child: Text(l10n.english)),
            DropdownMenuItem(value: 'es', child: Text(l10n.spanish)),
          ],
          onChanged: (value) async {
            if (value == null) return;
            await _preferences.saveLanguage(value);
            if (mounted) setState(() => _language = value);
          },
        ),
      ),
    );
  }
}
