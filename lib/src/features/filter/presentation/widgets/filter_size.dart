import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/dialog/signin_dialog.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/components/switch/custom_switch.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:qwid/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSize extends StatelessWidget {
  const FilterSize({super.key, required this.item});

  final FilterClass item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => previous.token != current.token,
          builder: (ctx, authState) {
            return BlocBuilder<FilterSortCubit, FilterSortState>(
              buildWhen: (previous, current) =>
                  previous.turnOnMySize != current.turnOnMySize,
              builder: (context, state) {
                return ElevatedAppButton(
                  height: 48,
                  onPressed: () async {
                    if (authState.isSignedIn) {
                      context
                          .read<FilterSortCubit>()
                          .toggleTurnOnMySize(!(state.turnOnMySize ?? false));
                    } else {
                      final res = await showDialog(
                        context: context,
                        builder: (context) => SigninDialog(
                          title: 'Join DW',
                          subTitle:
                              'Buy & sell pre-loved designer fashion! Join us now.',
                        ),
                      );

                      print(res);

                      if (authState.isSignedIn) {
                        context.read<FilterSortCubit>().getMySizes();
                      }
                    }
                  },
                  bgColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 0, 9, 0),
                  radius: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'filter_sort.turn_on_my_size'.tr(),
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
                              value: state.turnOnMySize ?? false),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        CustomDivider(),
        ElevatedAppButton(
          onPressed: () {
            context.router.push(
              YourFilterSizeRoute(
                  item: item,
                  selectedItem:
                      context.read<FilterSortCubit>().state.selectedSizes ??
                          <FilterClass>[]),
            );
          },
          height: 48,
          bgColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          radius: 0,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'filter_sort.edit_my_size'.tr(),
                  style: AppStyles.of(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 32),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Theme.of(context).extension<AppColors>()!.black,
              ),
            ],
          ),
        ),
        CustomDivider(),
      ],
    );
  }
}
