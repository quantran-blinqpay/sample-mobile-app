// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/appbar/custom_app_bar.dart';
import 'package:qwid/src/components/checkbox/custom_checkbox.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/components/radio/custom_radio.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:qwid/src/features/filter/presentation/widgets/filter_category.dart';
import 'package:qwid/src/features/filter/presentation/widgets/multi_checkbox_colour.dart';
import 'package:qwid/src/features/filter/presentation/widgets/multi_checkbox_condition.dart';
import 'package:qwid/src/features/filter/presentation/widgets/filter_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EnumSelectFilterType {
  radio,
  multiCheckbox,
  checkbox,
  price,
  size,
  category
}

enum EnumFilterSortType {
  sortBy,
  category,
  size,
  colour,
  price,
  discount,
  condition,
  itemLocation
}

@RoutePage(name: detailFilterSortScreenName)
class DetailFilterSortScreen extends StatefulWidget {
  DetailFilterSortScreen({
    super.key,
    required this.appbarTitle,
    required this.filterSortType,
    required this.selectFilterType,
    this.data,
  });

  String appbarTitle;
  EnumFilterSortType filterSortType;
  EnumSelectFilterType selectFilterType;
  List<FilterClass>? data;

  @override
  State<DetailFilterSortScreen> createState() => _DetailFilterSortScreenState();
}

class _DetailFilterSortScreenState extends State<DetailFilterSortScreen> {
  late AppColors? appColors;
  late BuildContext _currentContext;
  Timer? _debounce;
  final Duration _debounceDuration = Duration(milliseconds: 500);
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Object? getStateByType(FilterSortState state) {
    switch (widget.filterSortType) {
      case EnumFilterSortType.sortBy:
        return state.selectedSortBy.id;
      case EnumFilterSortType.discount:
        return state.selectedDiscount.id;
      case EnumFilterSortType.itemLocation:
        return state.selectedItemLocation?.id;

      default:
        return null;
    }
  }

  void handleOnPressedByType(FilterClass value) {
    switch (widget.filterSortType) {
      case EnumFilterSortType.sortBy:
        return _currentContext.read<FilterSortCubit>().onSelectSortBy(value);

      case EnumFilterSortType.discount:
        return _currentContext.read<FilterSortCubit>().onSelectDiscount(value);

      case EnumFilterSortType.itemLocation:
        return _currentContext
            .read<FilterSortCubit>()
            .onSelectItemLocation(value);

      default:
        return;
    }
  }

  void handleOnClearByType(FilterSortState state, String value) {
    switch (widget.filterSortType) {
      case EnumFilterSortType.category:
        return _currentContext
            .read<FilterSortCubit>()
            .onSelectCategory(null, isClear: true);

      case EnumFilterSortType.colour:
        return _currentContext
            .read<FilterSortCubit>()
            .onSelectColour(null, isClear: true);

      case EnumFilterSortType.condition:
        return _currentContext
            .read<FilterSortCubit>()
            .onSelectCondition(null, isClear: true);

      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();

    return _buildScaffoldWidget(
      child: Column(
        children: [
          BlocBuilder<FilterSortCubit, FilterSortState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: widget.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final item = widget.data![index];
                    switch (widget.selectFilterType) {
                      case EnumSelectFilterType.multiCheckbox:
                        if (widget.filterSortType ==
                            EnumFilterSortType.colour) {
                          return MultiCheckboxColour(item: item);
                        }

                        return MultiCheckboxCondition(item: item);

                      case EnumSelectFilterType.checkbox:
                        return _buildTypeCheckbox(item);

                      case EnumSelectFilterType.radio:
                        return _buildTypeRadio(item);

                      case EnumSelectFilterType.price:
                        return _buildTypePrice(item);

                      case EnumSelectFilterType.size:
                        return FilterSize(item: item);

                      case EnumSelectFilterType.category:
                        return FilterCategory(item: item);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeRadio(FilterClass item) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          builder: (context, state) {
            return ElevatedAppButton(
              onPressed: () => handleOnPressedByType(item),
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              radius: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name ?? '',
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: CustomRadio(
                      value: item.id,
                      groupValue: getStateByType(state),
                      onChanged: (v) {},
                      activeColor: Colors.black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        CustomDivider(),
      ],
    );
  }

  Widget _buildTypePrice(FilterClass item) {
    return BlocBuilder<FilterSortCubit, FilterSortState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 21, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'filter_sort.price_from'.tr(),
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextField(
                      onChanged: (v) {
                        _debounce?.cancel();
                        _debounce = Timer(_debounceDuration, () {
                          _currentContext
                              .read<FilterSortCubit>()
                              .onSelectPrice(v, state.priceTo ?? '');
                        });
                      },
                      onClear: () {
                        _currentContext
                            .read<FilterSortCubit>()
                            .onSelectPrice('', state.priceTo ?? '');
                      },
                      controller: TextEditingController(text: state.priceFrom),
                      keyboardType: TextInputType.number,
                      hintText: "\$0.00",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintStyle: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        color: appColors!.mediumGray,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    CustomDivider(),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'filter_sort.to'.tr(),
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextField(
                      onChanged: (v) {
                        _debounce?.cancel();
                        _debounce = Timer(_debounceDuration, () {
                          _currentContext
                              .read<FilterSortCubit>()
                              .onSelectPrice(state.priceFrom ?? '', v);
                        });
                      },
                      onClear: () {
                        _currentContext
                            .read<FilterSortCubit>()
                            .onSelectPrice(state.priceFrom ?? '', '');
                      },
                      controller: TextEditingController(text: state.priceTo),
                      keyboardType: TextInputType.number,
                      hintText: "\$",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintStyle: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        color: appColors!.mediumGray,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    CustomDivider(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeCheckbox(FilterClass item) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          builder: (context, state) {
            return ElevatedAppButton(
              onPressed: () => handleOnPressedByType(item),
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              radius: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name ?? '',
                      style: AppStyles.of(_currentContext).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: CustomCheckbox(
                      value: getStateByType(state) == item.id,
                      onChanged: (v) {},
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      borderColor: Colors.black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        CustomDivider(),
      ],
    );
  }

  Widget _buildScaffoldWidget({required Widget child}) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomNativeAppBar(
        title: widget.appbarTitle.toUpperCase(),
        hadBottomLine: true,
        actions: [
          if (widget.selectFilterType == EnumSelectFilterType.multiCheckbox ||
              widget.selectFilterType == EnumSelectFilterType.price ||
              widget.selectFilterType == EnumSelectFilterType.category)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: BlocBuilder<FilterSortCubit, FilterSortState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      handleOnClearByType(state, '');
                      if (widget.filterSortType ==
                          EnumFilterSortType.category) {
                        context.router
                            .popUntilRouteWithName(filterSortScreenName);
                      }
                    },
                    child: Text(
                      'filter_sort.clear'.tr(),
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.dimGray,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      body: child,
      bottomNavigationBar: widget.filterSortType == EnumFilterSortType.colour
          ? null
          : BottomAppBar(
              elevation: 0,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(11, 11, 11, 19),
              child: AppButton(
                title: widget.filterSortType == EnumFilterSortType.size
                    ? 'filter_sort.apply'.tr()
                    : 'filter_sort.show_results'.tr(),
                onPressed: () {
                  context.router.popUntilRouteWithName(filterScreenName);
                },
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
            ),
    );
  }
}
