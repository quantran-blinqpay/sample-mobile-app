import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/global/global_event.dart';
import 'package:designerwardrobe/src/core/shared_prefs/theme_mode_storage.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(themeMode: ThemeMode.light));

  void updateTheme(ThemeMode mode) async{
    await di<ThemeModeStorage>().write(mode == ThemeMode.dark ? true: false);
    GlobalEvent.instance.refreshThemeEvent.add(mode);
    emit(ThemeChanged(themeMode: mode));
  }

  void initTheme() async {
    bool? isDarkTheme = await di<ThemeModeStorage>().read();
    emit(ThemeChanged(themeMode: (isDarkTheme ?? false) ? ThemeMode.dark: ThemeMode.light));
  }
}
