part of '../router.dart';

final _homeRoutes = [
  AutoRoute(path: 'splash', page: SplashScreenRoute.page, initial: true),
  AutoRoute(path: 'home-wrapper', page: HomeWrapperScreenRoute.page),
  AutoRoute(path: 'pagination', page: PaginationScreenRoute.page),
  ..._authRoutes,

];
