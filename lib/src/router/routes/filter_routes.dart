part of '../router.dart';

final _filterRoutes = [
  AutoRoute(
    path: 'filter-wrapper',
    page: FilterWrapperScreenRoute.page,

    /// Những thg con bên trong sẽ được hưởng context cho cubit và không phải khai báo implement AutoRouteWrapper
    children: [
      /// path = '' => sẽ hiểu page đó là màn gốc cho wrapper này
      AutoRoute(path: '', page: FilterRoute.page),
      CustomRoute(
        path: 'filter_sort-in',
        page: FilterSortRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
      AutoRoute(path: 'detail_filter_sort', page: DetailFilterSortRoute.page),
      AutoRoute(path: 'filter_brand', page: FilterBrandRoute.page),
      AutoRoute(path: 'your_filter_size', page: YourFilterSizeRoute.page)
    ],
  ),
];
