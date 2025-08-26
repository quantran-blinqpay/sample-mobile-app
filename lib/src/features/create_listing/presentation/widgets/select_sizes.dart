// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: selectSizesScreenName)
class SelectSizes extends StatefulWidget {
  const SelectSizes({super.key, required this.data});
  final List<FilterSizeResponse> data;
  @override
  State<SelectSizes> createState() => _SelectSizesState();
}

class _SelectSizesState extends State<SelectSizes> {
  late AppColors? appColors;
  List<FilterSizeResponse> data = [];
  List<FilterSizeResponse> selectedItems = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      data = widget.data;
      selectedItems = [
        ...context.read<CreateListingCubit>().state.sizes ??
            <FilterSizeResponse>[]
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
                    'Select Sizes',
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
                                .updateSizes(selectedItems);

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
                        return e.genericSize?.toLowerCase().contains(
                                searchController.text.trim().toLowerCase()) ??
                            false;
                      },
                    ).toList();
                    setState(() {});
                  },
                  height: 40,
                  controller: searchController,
                  hintText: 'Select sizes...',
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
                                  Expanded(
                                    child: Text(
                                      (state.category?.urlTitle
                                                  ?.startsWith('kids-') ??
                                              false)
                                          ? item.genericSize ?? ''
                                          : '${item.genericSize ?? ''}/${item.altSize}',
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
