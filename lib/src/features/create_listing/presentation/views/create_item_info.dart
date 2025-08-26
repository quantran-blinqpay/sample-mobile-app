// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/form/app_form.dart';
import 'package:designerwardrobe/src/components/text_field/app_text_form_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/core/utils/text_utils.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/search_brands_response.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class CreateItemInfo extends StatelessWidget {
  CreateItemInfo({
    super.key,
    required this.brandController,
    required this.sizeController,
    required this.colourController,
    required this.conditionController,
  });

  late AppColors appColors;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  final TextEditingController brandController;
  final TextEditingController sizeController;
  final TextEditingController colourController;
  final TextEditingController conditionController;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocConsumer<CreateListingCubit, CreateListingState>(
      listenWhen: (prev, current) =>
          prev.brand != current.brand ||
          prev.sizes != current.sizes ||
          prev.colours != current.colours ||
          prev.condition != current.condition,
      listener: (context, s) {
        TextUtils.setTextSafely(brandController, s.brand?.name ?? '');
        TextUtils.setTextSafely(
          sizeController,
          s.sizes?.map((e) => e.genericSize).join(', ') ?? '',
        );
        TextUtils.setTextSafely(
          colourController,
          s.colours?.map((e) => e.name).join(', ') ?? '',
        );
        TextUtils.setTextSafely(
          conditionController,
          s.condition?.id != null
              ? '${s.condition?.title ?? ''} (${s.condition?.subTitle ?? ''})'
              : '',
        );
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Item info',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 24),
            if (state.department?.id != null && state.department?.id != 93) ...[
              _buildSelectTextField(
                context,
                () {
                  context.router.push(SelectBrandsScreenRoute());
                },
                () {
                  context
                      .read<CreateListingCubit>()
                      .updateBrand(SearchBrandsResponse());
                },
                'Brand',
                'Start typing brand/designer',
                brandController,
                prefixIcon: SvgPicture.asset(
                  Assets.svgs.icSearch2,
                  colorFilter: ColorFilter.mode(
                    appColors.silverSand,
                    BlendMode.srcIn,
                  ),
                ),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return FTextFieldStatus(
                        status: TFStatus.error, message: '');
                  } else {
                    return FTextFieldStatus(
                        status: TFStatus.normal, message: null);
                  }
                },
              ),
              SizedBox(height: 16),
            ],
            if ((state.category?.genericSizes?.isNotEmpty ?? false) ||
                (state.subCategory?.genericSizes?.isNotEmpty ?? false) ||
                (state.secondsubCategory?.genericSizes?.isNotEmpty ??
                    false)) ...[
              _buildSelectTextField(
                context,
                () {
                  final candidates = <List<FilterSizeResponse>?>[
                    state.category?.genericSizes,
                    state.subCategory?.genericSizes,
                    state.secondsubCategory?.genericSizes,
                  ];

                  final data = candidates
                          .firstWhereOrNull((l) => l?.isNotEmpty == true) ??
                      const <FilterSizeResponse>[];

                  /**
                   * Nếu như category là thuộc về Kids, thì mình sort theo altsize
                   * Sẽ hiển thị theo format generic size / alt size.
                   * Còn nếu ko phải Kids thì chỉ generic size thôi
                   */
                  if (state.category?.urlTitle?.startsWith('kids-') ?? false) {
                    data.sort(
                        (a, b) => (a.altSize ?? '').compareTo(b.altSize ?? ''));
                  }

                  context.router.push(SelectSizesScreenRoute(data: data));
                },
                () {},
                'Size(s)',
                '',
                sizeController,
                isListSizes: true,
                listSizes: state.sizes,
                onClearListSizes: (size) {
                  context.read<CreateListingCubit>().removeSize(size);
                },
                isTypeKid:
                    (state.category?.urlTitle?.startsWith('kids-') ?? false),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return FTextFieldStatus(
                        status: TFStatus.error, message: '');
                  } else {
                    return FTextFieldStatus(
                        status: TFStatus.normal, message: null);
                  }
                },
              ),
              SizedBox(height: 16),
            ],
            _buildSelectTextField(
              context,
              () {
                context.router.push(SelectColoursScreenRoute(
                  data: dataStartup?.colours?.toColourList() ?? <FilterClass>[],
                ));
              },
              () {},
              'Colour(s)',
              '',
              colourController,
              isListColours: true,
              listColours: state.colours,
              onClearListColours: (color) {
                context.read<CreateListingCubit>().removeColour(color);
              },
            ),
            if (state.category?.id != null) ...[
              SizedBox(height: 16),
              _buildSelectTextField(
                context,
                () {
                  context.router.push(SelectConditionScreenRoute(
                    data: state.dataCondition ??
                        dataStartup?.conditions?.data ??
                        <FilterItemResponse>[],
                  ));
                },
                () {
                  context
                      .read<CreateListingCubit>()
                      .updateCondition(FilterItemResponse());
                },
                'Condition',
                '',
                conditionController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return FTextFieldStatus(
                        status: TFStatus.error, message: '');
                  } else {
                    return FTextFieldStatus(
                        status: TFStatus.normal, message: null);
                  }
                },
              ),
            ],
            SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Padding _buildSelectTextField(
    BuildContext context,
    Function()? onTap,
    Function()? onClear,
    String title,
    String hintText,
    TextEditingController controller, {
    Widget? prefixIcon,
    bool isListColours = false,
    bool isListSizes = false,
    List<FilterClass>? listColours,
    Function(FilterClass)? onClearListColours,
    List<FilterSizeResponse>? listSizes,
    Function(FilterSizeResponse)? onClearListSizes,
    bool isTypeKid = true,
    FTextFieldStatus? Function(String?)? validator,
  }) {
    return Padding(
      key: Key(title),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.of(context).copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: appColors.darkGray,
            ),
          ),
          SizedBox(height: 6),
          if (isListColours && (listColours?.isNotEmpty ?? false))
            _buildRowColorWidget(
              onTap,
              listColours,
              onClearListColours,
            )
          else if (isListSizes && (listSizes?.isNotEmpty ?? false))
            _buildRowSizeWidget(
              context,
              onTap,
              listSizes,
              onClearListSizes,
              isTypeKid,
            )
          else
            AppTextFormField(
              onTap: onTap,
              onClear: onClear,
              controller: controller,
              hintText: hintText,
              readOnly: true,
              prefixIcon: prefixIcon,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.keyboard_arrow_right_rounded),
              ),
              validator: validator,
            ),
        ],
      ),
    );
  }

  GestureDetector _buildRowColorWidget(
    Function()? onTap,
    List<FilterClass>? listColours,
    Function(FilterClass)? onClearListColours,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
        decoration: BoxDecoration(
          border: Border.all(color: appColors.silverSand),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final itemColor in listColours ?? <FilterClass>[]) ...[
                    Builder(builder: (context) {
                      final color = itemColor.name?.toLowerCase() != 'various'
                          ? Color(
                              int.parse(itemColor.id!.substring(1), radix: 16) +
                                  0xFF000000)
                          : Colors.transparent;
                      return Container(
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appColors.lightGray,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (onClearListColours != null) {
                                  onClearListColours(itemColor);
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: appColors.lightGray,
                                ),
                                child: SvgPicture.asset(
                                  Assets.svgs.icClose,
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color:
                                    itemColor.name?.toLowerCase() == 'various'
                                        ? null
                                        : color,
                                gradient: itemColor.name?.toLowerCase() ==
                                        'various'
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
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              itemColor.name ?? '',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: appColors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (itemColor != listColours?.last) SizedBox(width: 8)
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildRowSizeWidget(
      BuildContext context,
      Function()? onTap,
      List<FilterSizeResponse>? listSizes,
      Function(FilterSizeResponse)? onClearListSizes,
      bool isTypeKid) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
        decoration: BoxDecoration(
          border: Border.all(color: appColors.silverSand),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final itemSize
                      in listSizes ?? <FilterSizeResponse>[]) ...[
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: appColors.lightGray,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (onClearListSizes != null) {
                                onClearListSizes(itemSize);
                              }
                            },
                            child: Container(
                              height: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: appColors.lightGray,
                              ),
                              child: SvgPicture.asset(
                                Assets.svgs.icClose,
                                width: 12,
                                height: 12,
                              ),
                            ),
                          ),
                          Text(
                            isTypeKid
                                ? itemSize.genericSize ?? ''
                                : '${itemSize.genericSize ?? ''}/${itemSize.altSize ?? ''}',
                            style: AppStyles.of(context).copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: appColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (itemSize != listSizes?.last) SizedBox(width: 8)
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
