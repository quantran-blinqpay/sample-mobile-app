part of '../router.dart';

final _paymentRoutes = [
  AutoRoute(path: 'payment', page: PaymentWrapperScreenRoute.page, guards: [AuthGuard()],),
  AutoRoute(path: 'paymentWebView', page: PaymentWebViewScreenRoute.page, guards: [AuthGuard()],),
  // AutoRoute(path: 'payment', page: PaymentScreenRoute.page, guards: [AuthGuard()],),
  // AutoRoute(path: 'wallet', page: WalletScreenRoute.page, guards: [AuthGuard()],),
  // AutoRoute(path: 'seller', page: SellerScreenRoute.page, guards: [AuthGuard()],),
  // AutoRoute(path: 'change_password', page: ChangePasswordScreenRoute.page,)
];
