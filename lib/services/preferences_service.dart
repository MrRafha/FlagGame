import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _languageKey = 'languageCode';

  Future<String> loadLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_languageKey) ?? 'pt';
  }

  Future<void> saveLanguage(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, languageCode);
  }
}
