part of 'injections.dart';

void initMovie(GetIt di) {
  di
    ..registerSingleton<MovieDataCubit>(MovieDataCubit(di<MovieRepository>()))
    ..registerSingleton<MovieSelectorCubit>(MovieSelectorCubit());
}
