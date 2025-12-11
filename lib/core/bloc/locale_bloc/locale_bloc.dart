part of '../blocs.dart';

class LocaleBloc extends EnumBloc<AppLocale> {
  LocaleBloc()
      : super(
          AppLocale.values,
          initial: _getCurrentLocale(),
        );

  static AppLocale _getCurrentLocale() {
    // Try to get current locale from context if available
    final context = navigatorKey.currentContext;
    if (context != null) {
      final currentLocale = Localizations.localeOf(context);
      return AppLocale.fromLocale(currentLocale);
    }
    return AppLocale.english;
  }

  void changeLocale(AppLocale locale) {
    add(SelectEnumValue(locale));
  }
}
