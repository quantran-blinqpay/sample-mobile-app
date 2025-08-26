// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/app_constants.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_hits_response.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage(name: filterScreenName)
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late AppColors? appColors;
  late BuildContext _currentContext;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(
      () {
        context
            .read<FilterSortCubit>()
            .updateSearchText(_searchController.text.trim());
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<FilterSortCubit, FilterSortState>(
          builder: (context, filterState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _buildAppbar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// FILTER BUTTON
                  if (filterState.isFiltered())
                    Container(
                      height: 32,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        children: [
                          _buildFilter(true),
                          Row(
                            children: [
                              for (final type in listTypeFilterAndSort) ...[
                                _buildTag(
                                  type.name ?? '',
                                  filterState
                                      .checkFilteredForEachType(type.id ?? ''),
                                )
                              ]
                            ],
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_searchController.text.trim().isNotEmpty)
                                    Text(
                                      _searchController.text,
                                      style: AppStyles.of(_currentContext)
                                          .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: appColors!.black,
                                      ),
                                    ),
                                  Text(
                                    '${NumberFormat.compact().format(filterState.totalResult)} ${"filter_sort.results".tr()}',
                                    style:
                                        AppStyles.of(_currentContext).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: appColors!.dimGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _buildFilter(false),
                        ],
                      ),
                    ),
                  if (filterState.isFiltered())
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                      child: Text(
                        '${NumberFormat.compact().format(filterState.totalResult)} ${"filter_sort.results".tr()}',
                        style: AppStyles.of(_currentContext).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: appColors!.dimGray,
                        ),
                      ),
                    ),

                  /// LIST ITEM
                  if (filterState.fetchFilterStatus ==
                      ProgressStatus.inProgress)
                    _buildLoadingListItem()
                  else
                    Expanded(
                      child: SmartRefresher(
                        controller: filterState.refreshController,
                        onLoading: () async {
                          await context.read<FilterSortCubit>().onLoadmore();
                          filterState.refreshController.loadComplete();
                        },
                        enablePullUp: filterState.canLoadMoreItems,
                        onRefresh: () async {
                          await context
                              .read<FilterSortCubit>()
                              .onFilter(showLoading: false);
                          filterState.refreshController.refreshCompleted();
                        },
                        child: filterState.searchItems?.isNotEmpty ?? false
                            ? GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 21,
                                  childAspectRatio: 165 / 288,
                                ),
                                itemCount: filterState.searchItems?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final item =
                                      filterState.searchItems![index].data;
                                  return _buildItem(item, context, authState);
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "filter.no_result_found".tr(),
                                      style: AppStyles.of(context).copyWith(
                                        color: appColors!.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 21),
                                    Text(
                                      "filter.please_try_broader".tr(),
                                      style: AppStyles.of(context).copyWith(
                                        color: appColors!.outerSpace,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItem(
    FilterHitsResponse? item,
    BuildContext context,
    AuthState authState,
  ) {
    return ElevatedAppButton(
      onPressed: () {
        context.router.push(ItemDetailWrapperScreenRoute(id: item?.id ?? 0));
      },
      bgColor: appColors!.white,
      padding: EdgeInsets.zero,
      radius: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 165 / 200,
                child: AppImage(imageUrl: item?.primaryImage?.data?.url ?? ''),
              ),
              if (item?.user?.data?.isTopSeller ?? false)
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                    padding: EdgeInsets.all(6.6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFFC7AD),
                          Color(0xFFFFC0EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "filter_sort.top_seller".tr(),
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: appColors!.black,
                      ),
                    ),
                  ),
                ),
              if (item?.pricePattern?.isSale ?? false)
                Positioned(
                  bottom: 7,
                  right: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                    decoration: BoxDecoration(
                      color: appColors!.white,
                      border:
                          Border.all(width: 0.82, color: appColors!.gainsboro),
                      borderRadius: BorderRadius.circular(6.6),
                    ),
                    child: Text(
                      "filter.sale".tr(),
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: appColors!.brightRed,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Title & price
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      item?.brand?.data?.title ?? '',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      item?.title ?? '',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.dimGray,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (item?.sizes?.data
                          ?.map((e) => '${e.genericSize} / ${e.altSize}')
                          .join(', ')
                          .isNotEmpty ??
                      false)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        item?.sizes?.data
                                ?.map((e) => '${e.genericSize} / ${e.altSize}')
                                .join(', ') ??
                            '',
                        style: AppStyles.of(context).copyWith(
                          color: appColors!.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: _buildPrice(
                            item,
                            authState,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: ElevatedAppButton(
                          width: 32,
                          height: 32,
                          onPressed: () {},
                          bgColor: Colors.transparent,
                          radius: 32,
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(
                            Assets.svgs.icHeartFilled,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildPrice(
    FilterHitsResponse? item,
    AuthState authState,
  ) {
    final helperState = GetIt.instance<HelperCubit>().state;
    final isFromAud = context.read<AuthCubit>().state.isFromAud;

    final price = item?.pricePattern?.calSalePrice(
      isFromAud ?? false ? 'AU' : 'NZ',
      helperState.currencyRate?.rateAudToNzd ?? 1,
    );
    final originalPrice = item?.pricePattern?.calOriginalPrice(
      isFromAud ?? false ? 'AU' : 'NZ',
      helperState.currencyRate?.rateAudToNzd ?? 1,
    );
    final discount = item?.pricePattern?.calDiscountPercent(
      salePrice: price ?? 0,
      originalPrice: originalPrice ?? 0,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                '\$${(price ?? 0) % 1 == 0 ? price?.toInt() : price?.toStringAsFixed(2) ?? ''} ',
            style: AppStyles.of(context).copyWith(
              color: item?.pricePattern?.isSale ?? false
                  ? appColors!.red
                  : appColors!.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (originalPrice != price)
            TextSpan(
              text:
                  '\$${(originalPrice ?? 0) % 1 == 0 ? originalPrice?.toInt() : originalPrice?.toStringAsFixed(2) ?? ''}',
              style: AppStyles.of(context).copyWith(
                color: appColors!.nobel,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          if (discount != 0)
            TextSpan(
              text: '  $discount% off',
              style: AppStyles.of(context).copyWith(
                color: appColors!.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Expanded _buildLoadingListItem() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 21,
          childAspectRatio: 165 / 288,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 165 / 200, child: AppShimmer()),
              const SizedBox(height: 12),

              // Title & price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: 140,
                        height: 18,
                        child: AppShimmer(
                          cornerRadius: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: 120,
                        height: 18,
                        child: AppShimmer(
                          cornerRadius: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            height: 18,
                            child: AppShimmer(
                              cornerRadius: 2,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 30,
                            height: 18,
                            child: AppShimmer(
                              cornerRadius: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  CustomNativeAppBar _buildAppbar() {
    return CustomNativeAppBar(
      /// Dung maybePop() khi da o man wrapper
      onPressed: () => _currentContext.router.maybePop(),
      customTitle: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 8, 2),
        child: CustomTextFormField(
          onFieldSubmitted: (v) {
            if (v.trim().isNotEmpty) {
              _currentContext.read<FilterSortCubit>().onFilter();
            }
          },
          onClear: () {
            _currentContext.read<FilterSortCubit>().onFilter();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          textInputAction: TextInputAction.search,
          height: 40,
          controller: _searchController,
          hintText: "filter.search_for_anything".tr(),
          backgroundColor: Color(0xFFF2F2F3),
          prefixIcon: Container(
            width: 12,
            height: 12,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              Assets.svgs.icSearch2,
            ),
          ),
          shape: ShapeTextFieldButton.circle,
        ),
      ),
      hadBottomLine: true,
      titleSpacing: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border_outlined,
            size: 24,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  ElevatedAppButton _buildFilter(bool isFiltered) {
    return ElevatedAppButton(
      onPressed: () {
        _currentContext.router.push(FilterSortRoute());
      },
      bgColor: Colors.white,
      padding: EdgeInsets.zero,
      radius: 100,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 6, 14, 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: appColors!.silverSand),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "filter_sort.filter_sort".tr(),
              style: AppStyles.of(_currentContext).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: appColors!.black,
              ),
            ),
            SizedBox(width: 8),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(Assets.svgs.icFilter),
                if (isFiltered)
                  Positioned(
                    top: -1,
                    left: -3,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: appColors!.vividBlue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: appColors!.white,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String title, bool isTypeFiltered) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: isTypeFiltered ? appColors!.lavender : appColors!.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
            width: 1,
            color:
                isTypeFiltered ? appColors!.vividBlue : appColors!.silverSand),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isTypeFiltered)
            Icon(
              Icons.check,
              color: appColors!.vividBlue,
              size: 14,
            ),
          if (isTypeFiltered) SizedBox(width: 6),
          Text(
            title,
            style: AppStyles.of(_currentContext).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: appColors!.black,
            ),
          ),
        ],
      ),
    );
  }
}
