part of '../router.dart';

final _homeRoutes = [
  AutoRoute(path: 'splash', page: SplashScreenRoute.page, initial: true),
  AutoRoute(path: 'home-wrapper', page: HomeWrapperScreenRoute.page),
  ..._authRoutes,
  ..._qwidRoutes,

];
