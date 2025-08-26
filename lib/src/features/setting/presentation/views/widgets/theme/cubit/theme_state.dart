part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  ThemeState({required this.themeMode});
  ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

// ignore: must_be_immutable
class ThemeInitial extends ThemeState {
  ThemeInitial({required super.themeMode});

  @override
  List<Object> get props => [themeMode];
}

// ignore: must_be_immutable
class ThemeChanged extends ThemeState {
  ThemeChanged({required super.themeMode});

  @override
  List<Object> get props => [themeMode];
}

