part of 'app_theme.dart';

/// [_appBarTheme] acts as a getter to [AppBarTheme], based on some argument.
/// For example, with specific font.
AppBarTheme _appBarTheme({
  required TextTheme textTheme,
  required Color iconColor,
}) {
  return ThemeData.light().appBarTheme.copyWith(
        color: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: false,
      );
}
