import '../../domain/repository/locale_repository.dart';
import '../datasource/locale_local_data_source.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleLocalDataSource localDataSource;

  LocaleRepositoryImpl(this.localDataSource);

  @override
  Future<String?> getSavedLocale() {
    return localDataSource.getSavedLocale();
  }

  @override
  Future<void> saveLocale(String languageCode) {
    return localDataSource.cacheLocale(languageCode);
  }
}