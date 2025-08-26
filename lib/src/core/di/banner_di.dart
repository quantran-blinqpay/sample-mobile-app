part of 'injections.dart';

void initBanner(GetIt di) {
  di

    /// Repository
    ..registerSingleton<BannerRepository>(
        BannerRepositoryImpl())

    /// Cubit
    ..registerSingleton<BannerCubit>(BannerCubit(di<BannerRepository>()));
}
