import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/features/setting/presentation/views/widgets/language/item/language_item.dart';
import 'package:qwid/src/features/setting/presentation/views/widgets/theme/cubit/theme_cubit.dart';

class ThemeController extends ChangeNotifier {
  ThemeController({bool? initTheme}) {
    if (initTheme != null) {
      isDark = initTheme;
    }
  }
  late bool isDark;
}

class ThemeWidget extends StatelessWidget {

  const ThemeWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final ThemeController controller;
  final void Function(bool? obj) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (c) => di<ThemeCubit>()..initTheme(),
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return LanguageItem(
                    text: 'setting.light'.tr(),
                    enableSeparate: true,
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                      controller.isDark = false;
                      onChanged(false);
                    },
                    isSelected: state.themeMode == ThemeMode.light);
              },
            ),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return LanguageItem(
                    text: 'setting.dark'.tr(),
                    enableSeparate: true,
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                      controller.isDark = true;
                      onChanged(true);
                    },
                    isSelected: state.themeMode == ThemeMode.dark);
              },
            ),
          ],
        ));
  }
}
