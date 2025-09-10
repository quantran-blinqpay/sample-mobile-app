// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: selectConditionScreenName)
class SelectCondition extends StatefulWidget {
  const SelectCondition({
    super.key,
    required this.data,
  });

  final List<FilterItemResponse> data;

  @override
  State<SelectCondition> createState() => _SelectConditionState();
}

class _SelectConditionState extends State<SelectCondition> {
  late AppColors? appColors;
  List<FilterItemResponse> data = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      data = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return BlocBuilder<CreateListingCubit, CreateListingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.5),
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: 48,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    'Select Condition',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 18,
                      height: 13 / 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomDivider(),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                child: CustomTextFormField(
                  onChanged: (v) {
                    data = widget.data.where(
                      (e) {
                        return e.title?.toLowerCase().contains(
                                searchController.text.trim().toLowerCase()) ??
                            false;
                      },
                    ).toList();
                    setState(() {});
                  },
                  height: 40,
                  controller: searchController,
                  hintText: 'Search conditions...',
                  backgroundColor: Color(0xFFF2F2F3),
                  prefixIcon: Container(
                    width: 12,
                    height: 12,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Assets.svgs.icSearch2,
                      colorFilter: ColorFilter.mode(
                        appColors!.dimGray,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, MediaQuery.of(context).padding.bottom),
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return ElevatedAppButton(
                      onPressed: () async {
                        context
                            .read<CreateListingCubit>()
                            .updateCondition(item);

                        context.router
                            .popUntilRouteWithName(createListingScreenName);
                      },
                      bgColor: appColors!.white,
                      radius: 0,
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.title ?? ''} (${item.subTitle ?? ''})',
                                    style: AppStyles.of(context).copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  Assets.svgs.icCheckCircle,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    state.condition?.id == item.id
                                        ? appColors!.black
                                        : appColors!.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomDivider(),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
