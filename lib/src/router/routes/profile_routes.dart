part of '../router.dart';

final _profileRoutes = [
  AutoRoute(path: 'profile', page: ProfileScreenRoute.page, guards: [AuthGuard()],),
  AutoRoute(path: 'wallet', page: WalletScreenRoute.page, guards: [AuthGuard()],),
  AutoRoute(path: 'seller', page: SellerScreenRoute.page, guards: [AuthGuard()],),
  AutoRoute(path: 'drafts', page: DraftsScreenRoute.page, guards: [AuthGuard()],),
  AutoRoute(path: 'change_password', page: ChangePasswordScreenRoute.page,)
];
