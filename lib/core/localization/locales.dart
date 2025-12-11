import 'dart:ui';

abstract interface class Locales {
  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');
  static const Locale french = Locale('fr');
  static const Locale german = Locale('de');
  static const Locale spanish = Locale('es');
  static const Locale italian = Locale('it');
  static const Locale russian = Locale('ru');

  /// List of all supported locales
  static const List<Locale> all = [
    english,
    arabic,
    french,
    german,
    spanish,
    italian,
    russian,
  ];
}
