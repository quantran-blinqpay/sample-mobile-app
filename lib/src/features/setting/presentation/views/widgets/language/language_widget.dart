import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/features/setting/presentation/views/widgets/language/cubit/language_cubit.dart';
import 'package:qwid/src/features/setting/presentation/views/widgets/language/item/language_item.dart';

class LanguageController extends ChangeNotifier {
  LanguageController({Locale? initLocale}) {
    if (initLocale != null) {
      language = initLocale;
    }
  }
  late Locale language;
}

class LanguageWidget extends StatelessWidget {

  const LanguageWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final LanguageController controller;
  final void Function(Locale? obj) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (c) => di<LanguageCubit>()..updateLanguage(EasyLocalization.of(context)?.locale ?? const Locale('vi', 'VN')),
        child: Column(
          children: [
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                return LanguageItem(
                    text: 'English',
                    enableSeparate: true,
                    onTap: () {
                      context.read<LanguageCubit>().updateLanguage(const Locale('en', 'US'));
                      controller.language = const Locale('en', 'US');
                      onChanged(const Locale('en', 'US'));
                      EasyLocalization.of(context)?.setLocale(const Locale('en', 'US'));
                      WidgetsBinding.instance.performReassemble(); /// TODO must call it for refresh language
                    },
                    isSelected: state.locale.languageCode == 'en');
              },
            ),
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                return LanguageItem(
                    text: 'Tiếng Việt',
                    enableSeparate: true,
                    onTap: () {
                      context.read<LanguageCubit>().updateLanguage(const Locale('vi', 'VN'));
                      controller.language = const Locale('vi', 'VN');
                      onChanged(const Locale('vi', 'VN'));
                      EasyLocalization.of(context)?.setLocale(const Locale('vi', 'VN'));
                      WidgetsBinding.instance.performReassemble(); /// TODO must call it for refresh language
                    },
                    isSelected: state.locale.languageCode == 'vi');
              },
            ),
          ],
        ));
  }
}
