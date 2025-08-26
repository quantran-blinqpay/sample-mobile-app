// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

@RoutePage(name: selectDepartmentScreenName)
class SelectDepartment extends StatefulWidget {
  const SelectDepartment({
    super.key,
    required this.data,
  });

  final List<GetCategoryResponse> data;

  @override
  State<SelectDepartment> createState() => _SelectDepartmentState();
}

class _SelectDepartmentState extends State<SelectDepartment> {
  late AppColors? appColors;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  List<GetCategoryResponse> data = [];
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
                    'Select Department',
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
                  hintText: 'Search departments...',
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
                            .updateDepartment(item);

                        final data = dataStartup?.categories
                            ?.where((e) => e.parentId == item.id)
                            .toList();

                        if (data?.isNotEmpty ?? false) {
                          context.router.push(
                            SelectCategoryScreenRoute(
                              data: data ?? <GetCategoryResponse>[],
                            ),
                          );
                        } else {
                          context.router
                              .popUntilRouteWithName(createListingScreenName);
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
                                    item.title ?? '',
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
                                    state.department?.id == item.id
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
