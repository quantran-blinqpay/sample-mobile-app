part of '../router.dart';

final _createListingRoutes = [
  CustomRoute(
    path: 'create_listing_wrapper',
    page: CreateListingWrapperScreenRoute.page,
    transitionsBuilder: TransitionsBuilders.slideBottom,
    duration: Duration(milliseconds: 300),
    children: [
      AutoRoute(
        path: '',
        page: CreateListingScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_department',
        page: SelectDepartmentScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_category',
        page: SelectCategoryScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_sub_category',
        page: SelectSubCategoryScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_second_sub_category',
        page: SelectSecondSubCategoryScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_brands',
        page: SelectBrandsScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_sizes',
        page: SelectSizesScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_colours',
        page: SelectColoursScreenRoute.page,
      ),
      AutoRoute(
        path: 'select_condition',
        page: SelectConditionScreenRoute.page,
      ),
    ],
  ),
];
