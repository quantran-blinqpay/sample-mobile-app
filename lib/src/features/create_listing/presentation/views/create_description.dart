// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/form/app_form.dart';
import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/components/text_field/app_text_form_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/core/utils/text_utils.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

class CreateDescription extends StatelessWidget {
  CreateDescription({
    super.key,
    required this.titleController,
    required this.describeController,
    required this.departmentController,
    required this.categoryController,
    required this.subCategoryController,
    required this.secondSubCategoryController,
  });

  late AppColors appColors;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  final TextEditingController titleController;
  final TextEditingController describeController;
  final TextEditingController departmentController;
  final TextEditingController categoryController;
  final TextEditingController subCategoryController;
  final TextEditingController secondSubCategoryController;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocConsumer<CreateListingCubit, CreateListingState>(
      listenWhen: (prev, current) =>
          prev.title != current.title ||
          prev.describle != current.describle ||
          prev.department != current.department ||
          prev.category != current.category ||
          prev.subCategory != current.subCategory ||
          prev.secondsubCategory != current.secondsubCategory,
      listener: (context, s) {
        TextUtils.setTextSafely(titleController, s.title ?? '');
        TextUtils.setTextSafely(describeController, s.describle ?? '');
        TextUtils.setTextSafely(
            departmentController, s.department?.title ?? '');
        TextUtils.setTextSafely(categoryController, s.category?.title ?? '');
        TextUtils.setTextSafely(
            subCategoryController, s.subCategory?.title ?? '');
        TextUtils.setTextSafely(
            secondSubCategoryController, s.secondsubCategory?.title ?? '');
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Description',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// AI GEN
            if ((state.photos?.isNotEmpty ?? false) &&
                !(state.photos?.any((e) => e.isLoading ?? false) ?? true))
              _buildAIGenWidget(state, context),
            SizedBox(height: 24),

            ///
            _buildInputTextField(
              context,
              (v) {
                context.read<CreateListingCubit>().updateTitle(v);
              },
              'Title',
              'e.g. The Isabella Dress',
              titleController,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return FTextFieldStatus(status: TFStatus.error, message: '');
                } else {
                  return FTextFieldStatus(
                      status: TFStatus.normal, message: null);
                }
              },
            ),
            SizedBox(height: 16),
            _buildInputTextField(
              context,
              (v) {
                context.read<CreateListingCubit>().updateDescrible(v);
              },
              'Describe your item',
              'e.g. Barely worn, in very good condition, runs a bit large',
              describeController,
              maxLine: 4,
            ),
            SizedBox(height: 16),
            _buildSelectTextField(
              context,
              () {
                final data = dataStartup?.categories
                        ?.where((e) => e.parentId == null)
                        .toList() ??
                    [];

                context.router.push(
                  SelectDepartmentScreenRoute(data: data),
                );
              },
              () {
                context.read<CreateListingCubit>()
                  ..updateDepartment(GetCategoryResponse())
                  ..updateCategory(GetCategoryResponse())
                  ..updateSubCategory(GetCategoryResponse())
                  ..updateSecondSubCategory(GetCategoryResponse())
                  ..getConditions(null);
              },
              'Department',
              '',
              departmentController,
            ),
            if (state.department?.id != null) ...[
              SizedBox(height: 16),
              _buildSelectTextField(
                context,
                () {
                  final data = dataStartup?.categories
                      ?.where((e) => e.parentId == state.department?.id)
                      .toList();

                  context.router.push(
                    SelectCategoryScreenRoute(
                      data: data ?? <GetCategoryResponse>[],
                    ),
                  );
                },
                () {
                  context.read<CreateListingCubit>()
                    ..updateCategory(GetCategoryResponse())
                    ..updateSubCategory(GetCategoryResponse())
                    ..updateSecondSubCategory(GetCategoryResponse())
                    ..getConditions(null);
                },
                'Category',
                '',
                categoryController,
              ),
            ],
            if (dataStartup?.haveChidren(state.category?.id ?? -1) ??
                false) ...[
              SizedBox(height: 16),
              _buildSelectTextField(
                context,
                () {
                  final data = dataStartup?.categories
                      ?.where((e) => e.parentId == state.category?.id)
                      .toList();

                  context.router.push(
                    SelectSubCategoryScreenRoute(
                      data: data ?? <GetCategoryResponse>[],
                    ),
                  );
                },
                () {
                  context.read<CreateListingCubit>()
                    ..updateSubCategory(GetCategoryResponse())
                    ..updateSecondSubCategory(GetCategoryResponse())
                    ..getConditions(null);
                },
                'Sub-category',
                '',
                subCategoryController,
              ),
            ],
            if (dataStartup?.haveChidren(state.subCategory?.id ?? -1) ??
                false) ...[
              SizedBox(height: 16),
              _buildSelectTextField(
                context,
                () {
                  final data = dataStartup?.categories
                      ?.where((e) => e.parentId == state.subCategory?.id)
                      .toList();

                  context.router.push(
                    SelectSecondSubCategoryScreenRoute(
                      data: data ?? <GetCategoryResponse>[],
                    ),
                  );
                },
                () {
                  context.read<CreateListingCubit>()
                    ..updateSecondSubCategory(GetCategoryResponse())
                    ..getConditions(null);
                },
                'Second Sub-category',
                '',
                secondSubCategoryController,
              ),
            ],
            SizedBox(height: 24)
          ],
        );
      },
    );
  }

  Container _buildAIGenWidget(CreateListingState state, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffF5F9FF),
        border: Border.all(color: Color(0xffDEEAFC)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Shimmer(
                enabled: state.fetchAIStatus == ProgressStatus.inProgress,
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF37D7),
                    Color(0xFF7B00FF),
                    Color(0xFF0022EC),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                child: SvgPicture.asset(
                  Assets.svgs.icAi,
                  width: 16,
                  height: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                state.fetchAIStatus == ProgressStatus.inProgress
                    ? 'Writing title and description...'
                    : state.fetchAIStatus == ProgressStatus.success
                        ? 'Done! Start with this (you can tweak as needed):'
                        : 'No suggestion available',
                style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        Color(0xFFFF37D7),
                        Color(0xFF7B00FF),
                        Color(0xFF0022EC),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          if (state.fetchAIStatus == ProgressStatus.inProgress)
            _buildLoadingAI(context)
          else if (state.fetchAIStatus == ProgressStatus.success)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item title / style name',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: appColors.darkGray,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  state.dataAI?.title ?? '',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Description',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: appColors.darkGray,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  state.dataAI?.description ?? '',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedAppButton(
                      onPressed: () {
                        context.read<CreateListingCubit>().useDescByAi();
                      },
                      bgColor: appColors.black,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      radius: 100,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Use this',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 12.6,
                                fontWeight: FontWeight.w500,
                                color: appColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedAppButton(
                      onPressed: () {
                        context.read<CreateListingCubit>().buildDescByAi();
                      },
                      bgColor: appColors.white,
                      padding: EdgeInsets.zero,
                      radius: 100,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(color: appColors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Re-write',
                              style: AppStyles.of(context).copyWith(
                                fontSize: 12.6,
                                fontWeight: FontWeight.w500,
                                color: appColors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: SvgPicture.asset(
                                Assets.svgs.icShuffle,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            Text(
              'Try adding more images, or fill in the title and description manually',
              style: AppStyles.of(context).copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }

  Column _buildLoadingAI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer(
          width: MediaQuery.of(context).size.width / 4,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 3,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 2,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
        AppShimmer(
          width: MediaQuery.of(context).size.width / 1,
          height: 16,
          cornerRadius: 10,
        ),
        SizedBox(height: 6),
      ],
    );
  }

  Padding _buildInputTextField(
    BuildContext context,
    Function(String)? onChanged,
    String title,
    String hintText,
    TextEditingController controller, {
    int? maxLine = 1,
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
              color: appColors.mediumGray,
            ),
          ),
          SizedBox(height: 6),
          AppTextFormField(
            onChanged: onChanged,
            controller: controller,
            hintText: hintText,
            maxLines: maxLine,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Padding _buildSelectTextField(
    BuildContext context,
    Function()? onTap,
    Function()? onClear,
    String title,
    String hintText,
    TextEditingController controller,
  ) {
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
          AppTextFormField(
            onTap: onTap,
            onClear: onClear,
            controller: controller,
            hintText: hintText,
            readOnly: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return FTextFieldStatus(status: TFStatus.error, message: '');
              } else {
                return FTextFieldStatus(status: TFStatus.normal, message: null);
              }
            },
          ),
        ],
      ),
    );
  }
}
