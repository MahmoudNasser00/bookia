import '../repository/locale_repository.dart';

class SaveLocale {
  final LocaleRepository repository;

  SaveLocale(this.repository);

  Future<void> call(String languageCode) {
    return repository.saveLocale(languageCode);
  }
}