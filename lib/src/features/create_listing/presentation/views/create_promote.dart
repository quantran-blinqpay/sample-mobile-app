// ignore_for_file: must_be_immutable

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:gif/gif.dart';

class CreatePromote extends StatelessWidget {
  CreatePromote({
    super.key,
    required this.gifController,
    required this.gifHighlightController,
  });

  late AppColors appColors;
  final GifController gifController;
  final GifController gifHighlightController;
  final dataSiteSetting = GetIt.instance<HelperCubit>().state.siteSetting;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;

    return BlocBuilder<CreateListingCubit, CreateListingState>(
      buildWhen: (previous, current) =>
          previous.selectedBump != current.selectedBump ||
          previous.dataFreeBump != current.dataFreeBump,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Text(
                'Promote Your Listing',
                style: AppStyles.of(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Boost your visibility & increase your chance of a quick sale',
                style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            _buildGif(
              context,
              () async {
                if (state.selectedBump != EnumPromoteBump.bump) {
                  context
                      .read<CreateListingCubit>()
                      .selectedBump(EnumPromoteBump.bump);
                  gifController.reset();
                  await gifController.forward();
                } else {
                  context
                      .read<CreateListingCubit>()
                      .selectedBump(EnumPromoteBump.none);
                }
              },
              Assets.gifs.bumpV2.path,
              gifController,
              'Bump',
              (state.dataFreeBump?.availableFreeBump ?? 0) > 0
                  ? 'Free'
                  : '\$${dataSiteSetting?.listingBump?.topOnceOnly?.priceNzd3Day ?? 0}',
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Get up to ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '5x more views. ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Bump your listing on the top of the feed.',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              state.selectedBump == EnumPromoteBump.bump,
            ),
            _buildGif(
              context,
              () async {
                if (state.selectedBump != EnumPromoteBump.bumpHighlight) {
                  context
                      .read<CreateListingCubit>()
                      .selectedBump(EnumPromoteBump.bumpHighlight);
                  gifHighlightController.reset();
                  await gifHighlightController.forward();
                } else {
                  context
                      .read<CreateListingCubit>()
                      .selectedBump(EnumPromoteBump.none);
                }
              },
              Assets.gifs.bumpHighlightV2.path,
              gifHighlightController,
              'Bump & highlight',
              '\$${dataSiteSetting?.listingBump?.highlightAndTopDaily?.priceNzd3Day ?? 0}',
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Maximum exposure ',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          'for your listing to help ensure a super quick sale!',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              state.selectedBump == EnumPromoteBump.bumpHighlight,
            ),
            SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Container _buildGif(
    BuildContext context,
    Function() onPressed,
    String assets,
    GifController controller,
    String title,
    String value,
    Widget subTitle,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.silverSand),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gif(
                  image: AssetImage(assets),
                  controller: controller,
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: AppStyles.of(context).copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO_quangdm show webview
                            },
                            child: Container(
                              color: appColors.white,
                              padding: EdgeInsets.fromLTRB(12, 2, 6, 2),
                              child: SvgPicture.asset(
                                Assets.svgs.icInfoGrey,
                                width: 14,
                                height: 14,
                                colorFilter: ColorFilter.mode(
                                  appColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        value,
                        style: AppStyles.of(context).copyWith(
                          fontSize: 13,
                          color: appColors.dimGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      subTitle,
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          ElevatedAppButton(
            onPressed: onPressed,
            bgColor: isSelected ? appColors.black : appColors.white,
            padding: EdgeInsets.zero,
            radius: 100,
            child: Container(
              width: 100,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                border: isSelected
                    ? null
                    : Border.all(color: appColors.black, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 2),
                      child: Icon(
                        Icons.check,
                        color: appColors.white,
                        size: 21,
                      ),
                    ),
                  Text(
                    isSelected ? 'Added' : 'Add',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 12.6,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? appColors.white : appColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
