// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/features/filter/presentation/widgets/multi_checkbox_brand.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: filterBrandScreenName)
class FilterBrandScreenName extends StatelessWidget {
  FilterBrandScreenName({super.key});

  late AppColors? appColors;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomNativeAppBar(
        title: 'filter_sort.brand'.tr().toUpperCase(),
        hadBottomLine: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {
                context
                    .read<FilterSortCubit>()
                    .onSelectBrand(null, isClear: true);
              },
              child: Text(
                'filter_sort.clear'.tr(),
                style: AppStyles.of(context).copyWith(
                  color: appColors!.dimGray,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: CustomTextFormField(
              onChanged: (v) {
                context.read<FilterSortCubit>().onSearchBand(v);
              },
              onClear: () => context.read<FilterSortCubit>().initBrands(),
              height: 40,
              controller: searchController,
              hintText: "filter_sort.search_for_brands".tr(),
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
          BlocBuilder<FilterSortCubit, FilterSortState>(
            buildWhen: (previous, current) =>
                previous.dataBrand != current.dataBrand,
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemExtent: 52.5,
                  itemCount: state.dataBrand?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.dataBrand![index];
                    return MultiCheckboxBrand(item: item);
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(11, 11, 11, 19),
        child: AppButton(
          title: 'filter_sort.show_results'.tr(),
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
