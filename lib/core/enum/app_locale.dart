import 'dart:ui';

enum AppLocale {
  english('en', 'English', '🇺🇸'),
  arabic('ar', 'العربية', '🇸🇦'),
  german('de', 'Deutsch', '🇩🇪'),
  spanish('es', 'Español', '🇪🇸'),
  french('fr', 'Français', '🇫🇷'),
  italian('it', 'Italiano', '🇮🇹'),
  russian('ru', 'Русский', '🇷🇺');

  const AppLocale(this.code, this.name, this.flag);

  final String code;
  final String name;
  final String flag;

  Locale get locale => Locale(code);

  static AppLocale fromCode(String code) {
    return AppLocale.values.firstWhere(
      (locale) => locale.code == code,
      orElse: () => AppLocale.english,
    );
  }

  static AppLocale fromLocale(Locale locale) {
    return fromCode(locale.languageCode);
  }
}
