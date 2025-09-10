// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/appbar/custom_app_bar.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/constants/app_constants.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:qwid/src/features/filter/presentation/views/detail_filter_sort_screen.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:qwid/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:get_it/get_it.dart';

@RoutePage(name: filterSortScreenName)
class FilterSortScreen extends StatelessWidget {
  FilterSortScreen({super.key});
  late AppColors? appColors;
  late BuildContext _currentContext;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();

    return BlocBuilder<FilterSortCubit, FilterSortState>(
      builder: (context, state) {
        return _buildScaffoldWidget(
            child: SingleChildScrollView(
          child: Column(
            children: [
              /// SORT BY
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.sort_by'.tr(),
                      filterSortType: EnumFilterSortType.sortBy,
                      selectFilterType: EnumSelectFilterType.radio,
                      data: dataSortBy,
                    ),
                  );
                },
                'filter_sort.sort_by'.tr(),
                value: state.selectedSortBy,
              ),
              SizedBox(height: 12),

              /// CATEGORY
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.category'.tr(),
                      selectFilterType: EnumSelectFilterType.category,
                      filterSortType: EnumFilterSortType.category,
                      data: dataStartup?.toCategoriesItemList(),
                    ),
                  );
                },
                'filter_sort.category'.tr(),
                value: state.selectedCategory,
              ),
              CustomDivider(),

              /// BRAND
              _buildTypeRow(
                () {
                  context.read<FilterSortCubit>().initBrands();
                  context.router.push(FilterBrandRoute());
                },
                'filter_sort.brand'.tr(),
                listValue: state.selectedBrands ?? [],
                type: EnumSelectFilterType.multiCheckbox,
              ),
              CustomDivider(),

              /// SIZE
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.size'.tr(),
                      selectFilterType: EnumSelectFilterType.size,
                      filterSortType: EnumFilterSortType.size,
                      data: [FilterClass(id: 'dummyId', name: 'dummyName')],
                    ),
                  );
                },
                'filter_sort.size'.tr(),
                type: EnumSelectFilterType.size,
                isTurnOnMySize: (state.turnOnMySize ?? false) ||
                    (state.alwaysFilterByMySize ?? false),
                listValue: state.selectedSizes ?? [],
              ),
              SizedBox(height: 12),

              /// COLOUR
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.colour'.tr(),
                      selectFilterType: EnumSelectFilterType.multiCheckbox,
                      filterSortType: EnumFilterSortType.colour,
                      data: dataStartup?.colours?.toColourList(),
                    ),
                  );
                },
                'filter_sort.colour'.tr(),
                listValue: state.selectedColours ?? [],
                type: EnumSelectFilterType.multiCheckbox,
              ),
              CustomDivider(),

              /// PRICE
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.price'.tr(),
                      selectFilterType: EnumSelectFilterType.price,
                      filterSortType: EnumFilterSortType.price,
                      data: [FilterClass(id: 'dummyId', name: 'dummyName')],
                    ),
                  );
                },
                'filter_sort.price'.tr(),
                type: EnumSelectFilterType.price,
                value: FilterClass(
                    id: buildValuePrice(state), name: buildValuePrice(state)),
              ),
              CustomDivider(),

              /// DISCOUNT
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.discount'.tr(),
                      selectFilterType: EnumSelectFilterType.checkbox,
                      filterSortType: EnumFilterSortType.discount,
                      data: dataDiscount,
                    ),
                  );
                },
                'filter_sort.discount'.tr(),
                value: state.selectedDiscount,
              ),
              CustomDivider(),

              /// CONDITION
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.condition'.tr(),
                      selectFilterType: EnumSelectFilterType.multiCheckbox,
                      filterSortType: EnumFilterSortType.condition,
                      data: dataStartup?.conditions?.toConditionItemList(),
                    ),
                  );
                },
                'filter_sort.condition'.tr(),
                listValue: state.selectedConditions,
                type: EnumSelectFilterType.multiCheckbox,
              ),
              CustomDivider(),

              /// ITEM LOCATION
              _buildTypeRow(
                () {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: 'filter_sort.item_location'.tr(),
                      filterSortType: EnumFilterSortType.itemLocation,
                      selectFilterType: EnumSelectFilterType.radio,
                      data: dataItemLocation,
                    ),
                  );
                },
                'filter_sort.item_location'.tr(),
                value: state.selectedItemLocation,
              ),
            ],
          ),
        ));
      },
    );
  }

  String buildValuePrice(FilterSortState state) {
    if ((state.priceFrom?.isEmpty ?? true) &&
        (state.priceTo?.isEmpty ?? true)) {
      return '';
    }

    if ((state.priceFrom?.isEmpty ?? true) &&
        (state.priceTo?.isNotEmpty ?? false)) {
      return '\$${state.priceTo ?? ''} and under';
    }

    if ((state.priceFrom?.isNotEmpty ?? false) &&
        (state.priceTo?.isEmpty ?? true)) {
      return '\$${state.priceFrom ?? ''} and above';
    }
    return '\$${state.priceFrom ?? ''} - \$${state.priceTo ?? ''}';
  }

  ElevatedAppButton _buildTypeRow(
    Function()? onPressed,
    String title, {
    FilterClass? value,
    List<FilterClass>? listValue,
    EnumSelectFilterType? type = EnumSelectFilterType.radio,
    bool isTurnOnMySize = false,
  }) {
    String handleValue() {
      if (type == EnumSelectFilterType.multiCheckbox) {
        return listValue?.isNotEmpty ?? false
            ? listValue!.map((e) => e.name).join(', ')
            : 'All';
      }

      if (type == EnumSelectFilterType.size && isTurnOnMySize) {
        return listValue?.isNotEmpty ?? false ? listValue!.join(', ') : 'All';
      }
      return (value?.id?.isNotEmpty ?? false) ? value?.name ?? '' : 'All';
    }

    bool isSelected() {
      if (type == EnumSelectFilterType.size && isTurnOnMySize == false) {
        return false;
      }

      return ((value?.id?.isNotEmpty ?? false) && value?.id != 'All') ||
          (listValue?.isNotEmpty ?? false);
    }

    return ElevatedAppButton(
      onPressed: onPressed,
      bgColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      radius: 0,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: AppStyles.of(_currentContext).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    handleValue(),
                    style: AppStyles.of(_currentContext).copyWith(
                      fontSize: 14,
                      fontWeight:
                          isSelected() ? FontWeight.w500 : FontWeight.w400,
                      color: isSelected()
                          ? appColors!.vividBlue
                          : appColors!.dimGray,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 18),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaffoldWidget({required Widget child}) {
    return Scaffold(
      backgroundColor: appColors!.lavender,
      appBar: CustomNativeAppBar(
        title: 'filter_sort.filter_sort'.tr().toUpperCase(),
        useCloseIcon: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {
                _currentContext.read<FilterSortCubit>().clearAll();
              },
              child: Text(
                'filter_sort.clear_all'.tr(),
                style: AppStyles.of(_currentContext).copyWith(
                  color: appColors!.dimGray,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(11, 11, 11, 19),
        child: AppButton(
          title: 'filter_sort.show_results'.tr(),
          onPressed: () {
            _currentContext.router.popUntilRouteWithName(filterScreenName);
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
