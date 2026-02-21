import '../repository/locale_repository.dart';

class GetSavedLocale {
  final LocaleRepository repository;

  GetSavedLocale(this.repository);

  Future<String?> call() {
    return repository.getSavedLocale();
  }
}