import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial(locale: const Locale('vi', 'VN')));

  void updateLanguage(Locale locale) {
    emit(LanguageChanged(locale: locale));
  }
}
