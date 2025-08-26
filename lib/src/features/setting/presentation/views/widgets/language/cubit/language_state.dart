part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  LanguageState({required this.locale});

  Locale locale;

  @override
  List<Object> get props => [locale];
}

// ignore: must_be_immutable
class LanguageInitial extends LanguageState {
  LanguageInitial({required super.locale});

  @override
  List<Object> get props => [locale];
}

// ignore: must_be_immutable
class LanguageChanged extends LanguageState {
  LanguageChanged({required super.locale});

  @override
  List<Object> get props => [locale];
}

