part of '../router.dart';

final _itemDetailRoutes = [
  AutoRoute(
    path: 'item_detail_wrapper',
    page: ItemDetailWrapperScreenRoute.page,
    children: [
      AutoRoute(path: '', page: ItemDetailScreenRoute.page),
    ],
  ),
];
