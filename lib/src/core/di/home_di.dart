part of 'injections.dart';

void injectHomeDependencies(GetIt di) {
  di
    ..registerSingleton<HomeCubit>(HomeCubit(di<HomeRepository>()))
    ..registerSingleton<MainTabCubit>(MainTabCubit());
}