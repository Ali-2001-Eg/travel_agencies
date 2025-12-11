import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'locales.dart';
import 'codegen_loader.g.dart';

abstract interface class LocalizationService {
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  static Widget rootWidget({required Widget child}) {
    // Access device's locale using PlatformDispatcher
    final deviceLocale = PlatformDispatcher.instance.locale;

    // Determine start locale based on device locale
    // Check if device language is supported, otherwise default to English
    final startLocale = _getStartLocale(deviceLocale.languageCode);

    return EasyLocalization(
      saveLocale: true,
      supportedLocales: Locales.all,
      path: 'assets/translations',
      startLocale: startLocale,
      fallbackLocale: Locales.english,
      assetLoader: const CodegenLoader(),
      child: child,
    );
  }

  /// Determines the start locale based on the device's language code
  static Locale _getStartLocale(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return Locales.arabic;
      case 'fr':
        return Locales.french;
      case 'de':
        return Locales.german;
      case 'es':
        return Locales.spanish;
      case 'it':
        return Locales.italian;
      case 'ru':
        return Locales.russian;
      case 'en':
      default:
        return Locales.english;
    }
  }
}
