// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/divider/custom_divider.dart';
import 'package:qwid/src/components/loading_indicator/app_shimmer.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: selectBrandsScreenName)
class SelectBrands extends StatefulWidget {
  const SelectBrands({super.key});

  @override
  State<SelectBrands> createState() => _SelectBrandsState();
}

class _SelectBrandsState extends State<SelectBrands> {
  late AppColors? appColors;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  final Duration _debounceDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateListingCubit>();
    if (cubit.state.brand?.id != null) {
      searchController.text = cubit.state.brand?.name ?? '';
    }

    cubit.searchBrands(searchController.text.trim());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
                    'Select Brand',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                child: CustomTextFormField(
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      _debounce?.cancel();
                      _debounce = Timer(_debounceDuration, () {
                        context
                            .read<CreateListingCubit>()
                            .searchBrands(searchController.text.trim());
                      });
                    }
                  },
                  onClear: () {
                    context.read<CreateListingCubit>().searchBrands('');
                  },
                  height: 40,
                  controller: searchController,
                  hintText: 'Select brands...',
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
              if (state.fetchSearchBrandsStatus == ProgressStatus.inProgress)
                Expanded(child: _buildLoading())
              else if (searchController.text.trim().isNotEmpty &&
                  (state.dataBrands?.isEmpty ?? true))
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedAppButton(
                    height: 50,
                    onPressed: () async {
                      // TODO_quangdm call POST api/brand/create {"brand":"something new","is_category":"is_beauty"}
                    },
                    bgColor: appColors!.black,
                    radius: 6,
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: appColors!.white),
                        SizedBox(width: 4),
                        Text(
                          'Add New Brand "${searchController.text.trim()}"',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 16,
                            color: appColors!.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                if (searchController.text.trim().isEmpty) ...[
                  Container(
                    height: 52,
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Popular brands',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        color: appColors!.neutralGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomDivider(),
                  ),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: state.dataBrands?.length ?? 0,
                    padding: EdgeInsets.fromLTRB(
                        16, 0, 16, MediaQuery.of(context).padding.bottom),
                    itemBuilder: (BuildContext context, int index) {
                      final item = state.dataBrands![index];
                      return ElevatedAppButton(
                        onPressed: () async {
                          context.read<CreateListingCubit>().updateBrand(item);

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
                                      state.brand?.id == item.id
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
            ],
          ),
        );
      },
    );
  }

  ListView _buildLoading() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      padding:
          EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).padding.bottom),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: AppShimmer(
                width: double.infinity,
                height: 19,
                cornerRadius: 8,
              ),
            ),
            CustomDivider(),
          ],
        );
      },
    );
  }
}
