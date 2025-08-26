import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/features/filter/presentation/views/detail_filter_sort_screen.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FilterCategory extends StatelessWidget {
  FilterCategory({super.key, required this.item});

  final FilterClass item;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          buildWhen: (previous, current) =>
              previous.selectedCategory != current.selectedCategory,
          builder: (context, state) {
            bool haveChidren =
                dataStartup?.haveChidren(int.tryParse(item.id ?? '') ?? 0) ??
                    false;

            return ElevatedAppButton(
              onPressed: () {
                context.read<FilterSortCubit>().onSelectCategory(
                      item,
                      mainCategory:
                          item.parentId == null ? item.urlTitle : null,
                    );

                if (haveChidren) {
                  context.router.push(
                    DetailFilterSortRoute(
                      appbarTitle: item.name ?? '',
                      selectFilterType: EnumSelectFilterType.category,
                      filterSortType: EnumFilterSortType.category,
                      data: dataStartup?.toCategoriesItemList(
                        parentId: int.tryParse(item.id ?? ''),
                      ),
                    ),
                  );
                } else {
                  context.router.popUntilRouteWithName(filterSortScreenName);
                }
              },
              height: 48,
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
              radius: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name ?? '',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: state.selectedCategory?.id == item.id
                            ? Theme.of(context)
                                .extension<AppColors>()!
                                .vividBlue
                            : Theme.of(context).extension<AppColors>()!.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 32),
                  if (haveChidren)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: state.selectedCategory?.id == item.id
                          ? Theme.of(context).extension<AppColors>()!.vividBlue
                          : Theme.of(context).extension<AppColors>()!.black,
                    ),
                ],
              ),
            );
          },
        ),
        CustomDivider(),
      ],
    );
  }
}
