part of 'change_theme_cubit.dart';

sealed class ChangeThemeStates extends Equatable {
  const ChangeThemeStates();

  @override
  List<Object> get props => [];
}

final class ChangeThemeInitial extends ChangeThemeStates {}

final class ThemeChanged extends ChangeThemeStates {
  final bool isDark;
  const ThemeChanged({required this.isDark});
  @override
  List<Object> get props => [isDark];
}
