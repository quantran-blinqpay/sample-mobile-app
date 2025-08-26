// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: selectColoursScreenName)
class SelectColours extends StatefulWidget {
  const SelectColours({super.key, required this.data});
  final List<FilterClass> data;
  @override
  State<SelectColours> createState() => _SelectColoursState();
}

class _SelectColoursState extends State<SelectColours> {
  late AppColors? appColors;
  List<FilterClass> data = [];
  List<FilterClass> selectedItems = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      data = widget.data;
      selectedItems = [
        ...context.read<CreateListingCubit>().state.colours ?? <FilterClass>[]
      ];
      selectedItems;
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
                    'Select Colours',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 18,
                      height: 13 / 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    BlocBuilder<CreateListingCubit, CreateListingState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            context
                                .read<CreateListingCubit>()
                                .updateColour(selectedItems);

                            context.router
                                .popUntilRouteWithName(createListingScreenName);
                          },
                          child: Text(
                            'Save',
                            style: AppStyles.of(context).copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                CustomDivider(),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                child: CustomTextFormField(
                  onChanged: (v) {
                    data = widget.data.where(
                      (e) {
                        return e.name?.toLowerCase().contains(
                                searchController.text.trim().toLowerCase()) ??
                            false;
                      },
                    ).toList();
                    setState(() {});
                  },
                  height: 40,
                  controller: searchController,
                  hintText: 'Select colours...',
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
                    final color = (item.id?.isNotEmpty ?? false) &&
                            item.id != 'various'
                        ? Color(int.parse(item.id!.substring(1), radix: 16) +
                            0xFF000000)
                        : Colors.transparent;

                    return Opacity(
                      opacity: selectedItems.length < 3
                          ? 1
                          : selectedItems.any((e) => e.id == item.id)
                              ? 1
                              : 0.5,
                      child: ElevatedAppButton(
                        onPressed: () async {
                          if (selectedItems.length < 3) {
                            if (selectedItems.any((e) => e.id == item.id)) {
                              selectedItems.removeWhere((e) => e.id == item.id);
                            } else {
                              selectedItems.add(item);
                            }
                            setState(() {});
                          } else {
                            if (selectedItems.any((e) => e.id == item.id)) {
                              selectedItems.removeWhere((e) => e.id == item.id);
                            }
                            setState(() {});
                          }
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
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: (item.id?.isNotEmpty ?? false) &&
                                              item.id != 'various'
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
                                              stops: [
                                                0.0,
                                                0.2,
                                                0.4,
                                                0.6,
                                                0.8,
                                                1.0
                                              ],
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
                                      selectedItems.any((e) => e.id == item.id)
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
