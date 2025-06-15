import 'package:shared_preferences/shared_preferences.dart';

class SearchStorage {
  static const _key = 'recent_searches';

  static Future<void> saveRecentQueries(List<String> queries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, queries);
  }

  static Future<List<String>> getRecentQueries() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}