import 'dart:ui';
// summary for the file //nn
// This file defines a Localization class that manages supported locales for the application.
// It includes English and Arabic locales, and provides a singleton instance for easy access throughout the app.
// The class can be used to retrieve the list of supported locales, which can be useful for localization purposes in a Flutter application.

class Localization {
  Locale enLocale = const Locale('en');
  Locale arLocale = const Locale('ar');

  List<Locale> get supportedLocales => <Locale>[arLocale, enLocale];

  static final Localization _instance = Localization._internal();

  static Localization get instance => _instance;

  factory Localization() {
    return _instance;
  }

  Localization._internal();
}
