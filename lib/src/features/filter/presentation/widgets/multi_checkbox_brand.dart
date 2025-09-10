import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/checkbox/custom_checkbox.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiCheckboxBrand extends StatelessWidget {
  const MultiCheckboxBrand({super.key, required this.item});

  final FilterClass item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          buildWhen: (previous, current) =>
              previous.selectedBrands != current.selectedBrands,
          builder: (context, state) {
            return ElevatedAppButton(
              onPressed: () {
                context.read<FilterSortCubit>().onSelectBrand(item);
              },
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
              radius: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name ?? '',
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
                    child: CustomCheckbox(
                      value:
                          state.selectedBrands?.any((e) => e.id == item.id) ??
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
