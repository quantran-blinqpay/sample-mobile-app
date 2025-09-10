import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/global/global_event.dart';
import 'package:qwid/src/core/shared_prefs/theme_mode_storage.dart';
import 'package:qwid/src/router/router.dart';

import 'src/configs/app_themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await initAwaitServices();
  var isDarkTheme = await di<ThemeModeStorage>().read();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // or any color you want
      statusBarIconBrightness:
          Brightness.dark, // dark = light theme (dark icons)
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: MyApp(isDarkTheme: isDarkTheme),
    ),
  );
}

// AWAIT SERVICES INITIALIZATION.
Future initAwaitServices() async {
  await Future.wait([Hive.initFlutter(), EasyLocalization.ensureInitialized()]);
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key, this.isDarkTheme});
  bool? isDarkTheme;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _rootRouter = di<RootRouter>();

  late ValueNotifier<ThemeMode> _notifier;

  @override
  void initState() {
    _notifier = ValueNotifier(
        (widget.isDarkTheme ?? false) ? ThemeMode.dark : ThemeMode.light);
    GlobalEvent.instance.refreshThemeEvent.stream.listen((mode) {
      _notifier.value = mode;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HelperCubit>(create: (context) => di<HelperCubit>()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: _notifier,
          builder: (_, mode, __) {
            return MaterialApp.router(
              routerConfig: _rootRouter.config(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              themeMode: mode,
              theme: getThemeDefault(),
              darkTheme: getDarkDefault(),
            );
          },
        ),
      ),
    );
  }
}
