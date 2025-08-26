import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/checkbox/custom_checkbox.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiCheckboxCondition extends StatelessWidget {
  const MultiCheckboxCondition({super.key, required this.item});

  final FilterClass item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          buildWhen: (previous, current) =>
              previous.selectedConditions != current.selectedConditions,
          builder: (context, state) {
            return ElevatedAppButton(
              onPressed: () {
                context.read<FilterSortCubit>().onSelectCondition(item);
              },
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 4, 4, 12),
              radius: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        Text(
                          item.name ?? '',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        if (item.subName?.isNotEmpty ?? false)
                          Text(
                            item.subName!,
                            style: AppStyles.of(context).copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .extension<AppColors>()!
                                  .mediumGray,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 32),
                  IgnorePointer(
                    ignoring: true,
                    child: CustomCheckbox(
                      value: state.selectedConditions
                              ?.any((e) => e.id == item.id) ??
                          false,
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
}
