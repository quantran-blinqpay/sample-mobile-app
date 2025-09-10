import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/checkbox/custom_checkbox.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiCheckboxColour extends StatelessWidget {
  const MultiCheckboxColour({super.key, required this.item});

  final FilterClass item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FilterSortCubit, FilterSortState>(
          buildWhen: (previous, current) =>
              previous.selectedColours != current.selectedColours,
          builder: (context, state) {
            final color = (item.id?.isNotEmpty ?? false) && item.id != 'various'
                ? Color(
                    int.parse(item.id!.substring(1), radix: 16) + 0xFF000000)
                : Colors.transparent;

            return ElevatedAppButton(
              onPressed: () {
                context.read<FilterSortCubit>().onSelectColour(item);
              },
              bgColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
              radius: 0,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color:
                          (item.id?.isNotEmpty ?? false) && item.id != 'various'
                              ? color
                              : null,
                      shape: BoxShape.circle,
                      border: color.computeLuminance() > 0.95 &&
                              (item.id?.isNotEmpty ?? false) &&
                              item.id != 'various'
                          ? Border.all(
                              color: Theme.of(context)
                                  .extension<AppColors>()!
                                  .veryLightGrey)
                          : null,
                      gradient: item.id == 'various'
                          ? SweepGradient(
                              colors: [
                                Color(0xff0022EC),
                                Color(0xffA612F8),
                                Color(0xffEF1470),
                                Color(0xffF3970D),
                                Color(0xffF3DD18),
                                Color(0xff59B124),
                              ],
                              stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                              center: Alignment.center,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 16),
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
                          state.selectedColours?.any((e) => e.id == item.id) ??
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
