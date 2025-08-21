part of 'change_mood_cubit.dart';

sealed class ChangeMoodStates extends Equatable {
  const ChangeMoodStates();

  @override
  List<Object> get props => [];
}

final class ChangeMoodInitial extends ChangeMoodStates {}

final class ThemeChanged extends ChangeMoodStates {
  final bool isDark;
  const ThemeChanged({required this.isDark});
  @override
  List<Object> get props => [isDark];
}
