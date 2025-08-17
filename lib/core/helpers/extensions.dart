import 'package:flutter/widgets.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName,
    bool Function(dynamic route) param1, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop({bool? isTrue}) => Navigator.of(this).pop(isTrue ?? false);
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";

  // String formatDateHeader() {
  //   if (this == null || this!.isEmpty) return "";

  //   final date = DateTime.parse(this!.replaceAll('.000000Z', 'Z'));
  //   if (!CacheHelper.isEnglish()) {
  //     return DateFormat('EEE, d MMM', 'ar').format(date);
  //   } else {
  //     return DateFormat('EEE, d MMM', 'en').format(date);
  //   }
  // }
}
