import 'package:shared_preferences/shared_preferences.dart';
import 'locale_local_data_source.dart';

class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  static const String key = 'language_code';

  @override
  Future<String?> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> cacheLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, languageCode);
  }
}