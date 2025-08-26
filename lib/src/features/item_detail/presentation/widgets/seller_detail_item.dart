// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/components/text_field/custom_text_field.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/purchase_dialog.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/rating_star.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SellerDetailItem extends StatelessWidget {
  SellerDetailItem({
    super.key,
    required this.data,
    required this.controller,
  });

  final ListingDetailResponseData? data;
  late AppColors? appColors;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return BlocBuilder<ItemDetailCubit, ItemDetailState>(
      buildWhen: (previous, current) =>
          previous.totalResult != current.totalResult ||
          previous.searchItems != current.searchItems ||
          previous.isShowQuestionField != current.isShowQuestionField ||
          previous.questionText != current.questionText ||
          previous.fetchAskQuestionStatus != current.fetchAskQuestionStatus,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 21, 0, 16),
          child: Builder(builder: (context) {
            final user = data?.user?.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: 37,
                            width: 37,
                            child: ClipOval(
                              child: AppImage(
                                  imageUrl: user?.profilePicture ?? ''),
                            ),
                          ),
                          if (user?.verifiedEmail == true &&
                              user?.verifiedFacebook == true)
                            Positioned(
                              right: -3,
                              bottom: -3,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(Assets.svgs.icStar),
                                  SvgPicture.asset(Assets.svgs.icCheck),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.username ?? '',
                              style: AppStyles.of(context).copyWith(
                                color: appColors!.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                StarRatingWidget(
                                  rating: ratingFromScore(
                                      user?.feedbackPercentage ?? 0),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '(${user?.counts?.totalFeedback()})',
                                  style: AppStyles.of(context).copyWith(
                                    color: appColors!.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (user?.isTopSeller ?? false)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFFC7AD),
                                Color(0xFFFFC0EF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "filter_sort.top_seller".tr(),
                            style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: appColors!.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'MORE FROM THIS SELLER',
                          style: AppStyles.of(context).copyWith(
                            color: appColors!.black,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${state.totalResult} LISTINGS',
                        style: AppStyles.of(context).copyWith(
                          color: appColors!.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.searchItems?.isNotEmpty ?? false)
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemCount: state.searchItems?.length ?? 0,
                      separatorBuilder: (_, __) => SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final moreItem = state.searchItems?[index].data;
                        return GestureDetector(
                          onTap: () {
                            context.router.push(ItemDetailWrapperScreenRoute(
                                id: moreItem?.id ?? 0));
                          },
                          child: SizedBox(
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(6),
                              child: AppImage(
                                  imageUrl: moreItem?.primaryImageUrl ?? ''),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedAppButton(
                          onPressed: () {
                            context
                                .read<ItemDetailCubit>()
                                .toggleShowQuestionField(true);
                          },
                          height: 35,
                          bgColor: appColors!.lavender,
                          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                          radius: 5,
                          child: Text(
                            'Ask a question',
                            style: AppStyles.of(context).copyWith(
                              color: appColors!.cobatBlue,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedAppButton(
                          onPressed: () {
                            // TODO_(Quangdm): View all listings
                          },
                          height: 35,
                          bgColor: appColors!.lavender,
                          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                          radius: 5,
                          child: Text(
                            'View all listings',
                            style: AppStyles.of(context).copyWith(
                              color: appColors!.cobatBlue,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isShowQuestionField)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 12, 10, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextFormField(
                          onChanged: (value) {
                            context
                                .read<ItemDetailCubit>()
                                .updateQuestionText(value);
                          },
                          enabledBorderColor: appColors!.gainsboro,
                          focusedBorderColor: appColors!.gainsboro,
                          controller: controller,
                          keyboardType: TextInputType.emailAddress,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          hintText: 'Ask a question...',
                          maxLines: 2,
                        ),
                        SizedBox(height: 18),
                        AppButton(
                          onPressed: () {
                            context.read<ItemDetailCubit>().askQuestion(
                              data?.id ?? 0,
                              {
                                "question": state.questionText?.trim(),
                                "is_private": false
                              },
                            );
                          },
                          width: null,
                          height: 35,
                          backgroundColor:
                              state.questionText?.isNotEmpty ?? false
                                  ? appColors!.vividBlue
                                  : appColors!.registerUnactivatedButtonColor,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          isLoading: state.fetchAskQuestionStatus ==
                              ProgressStatus.inProgress,
                          radius: 5,
                          title: 'Ask a question',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: appColors!.white,
                        ),
                      ],
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PurchaseDialog();
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(
                            Assets.svgs.icProtection,
                            colorFilter: ColorFilter.mode(
                              appColors!.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Purchase protection included',
                          style: AppStyles.of(context).copyWith(
                            color: appColors!.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  double ratingFromScore(int score) {
    if (score < 10) return 0.5;
    if (score < 20) return 1.0;
    if (score < 30) return 1.5;
    if (score < 40) return 2.0;
    if (score < 50) return 2.5;
    if (score < 60) return 3.0;
    if (score < 70) return 3.5;
    if (score < 80) return 4.0;
    if (score < 90) return 4.5;
    return 5.0;
  }
}
