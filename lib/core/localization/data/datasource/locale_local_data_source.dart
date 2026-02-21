abstract class LocaleLocalDataSource {
  Future<String?> getSavedLocale();
  Future<void> cacheLocale(String languageCode);
}