// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/switch/custom_switch.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: yourFilterSizeScreenName)
class YourFilterSize extends StatefulWidget {
  const YourFilterSize(
      {super.key, required this.item, required this.selectedItem});

  final FilterClass item;
  final List<FilterClass> selectedItem;

  @override
  State<YourFilterSize> createState() => _YourFilterSizeState();
}

class _YourFilterSizeState extends State<YourFilterSize> {
  late AppColors? appColors;
  late BuildContext _currentContext;
  List<FilterClass> selectedSizes = [];

  @override
  void initState() {
    super.initState();
    selectedSizes = [...(widget.selectedItem)];
  }

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      backgroundColor: appColors!.lavender,
      appBar: CustomNativeAppBar(
        title: 'filter_sort.your_sizes'.tr().toUpperCase(),
        hadBottomLine: true,
      ),
      body: BlocBuilder<FilterSortCubit, FilterSortState>(
        builder: (context, state) {
          return Column(
            children: [
              ElevatedAppButton(
                height: 48,
                onPressed: () {
                  context.read<FilterSortCubit>().toggleAlwaysFilterByMySize(
                      !(state.alwaysFilterByMySize ?? false));
                },
                bgColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 0, 9, 0),
                radius: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'filter_sort.always_filter_by_my_size'.tr(),
                        style: AppStyles.of(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 32),
                    IgnorePointer(
                      ignoring: true,
                      child: CustomSwitch(
                        controller: SwitchController(
                            value: state.alwaysFilterByMySize ?? false),
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Clothing Size",
                            style: AppStyles.of(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "NZ / AU",
                          style: AppStyles.of(context).copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appColors!.outerSpace,
                          ),
                        ),
                      ],
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 11,
                      childAspectRatio: 78 / 36,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 16),
                      children: clothingSizes.map((item) {
                        return _buildTag(
                          () {
                            setState(() {
                              if (selectedSizes.contains(item)) {
                                selectedSizes.remove(item);
                              } else {
                                selectedSizes.add(item);
                              }
                            });
                          },
                          item,
                          isSelected: selectedSizes.contains(item),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(11, 11, 11, 19),
        child: AppButton(
          title: 'filter_sort.save_sizes'.tr(),
          onPressed: () {
            _currentContext.read<FilterSortCubit>().onSaveSizes(selectedSizes);
            _currentContext.router.pop();
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }

  ElevatedAppButton _buildTag(
    Function()? onPressed,
    FilterClass item, {
    bool isSelected = false,
  }) {
    return ElevatedAppButton(
      onPressed: onPressed,
      bgColor: Colors.white,
      padding: EdgeInsets.zero,
      radius: 5,
      child: AspectRatio(
        aspectRatio: 78 / 36,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFFFC7AD),
                      Color(0xFFFFC0EF),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(5),
            border: isSelected
                ? null
                : Border.all(width: 0.5, color: appColors!.silverSand),
          ),
          child: Text(
            item.name ?? '',
            style: AppStyles.of(_currentContext).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

final List<FilterClass> clothingSizes = [
  FilterClass(id: '4 / XXS', name: '4 / XXS'),
  FilterClass(id: '6 / XS', name: '6 / XS'),
  FilterClass(id: '8 / S', name: '8 / S'),
  FilterClass(id: '10 / M', name: '10 / M'),
  FilterClass(id: '12 / L', name: '12 / L'),
  FilterClass(id: '14 / XL', name: '14 / XL'),
  FilterClass(id: '16 / 2XL', name: '16 / 2XL'),
  FilterClass(id: '18 / 3XL', name: '18 / 3XL'),
  FilterClass(id: 'OSFM', name: 'OSFM'),
  FilterClass(id: '20+ / 4XL+', name: '20+ / 4XL+'),
];
