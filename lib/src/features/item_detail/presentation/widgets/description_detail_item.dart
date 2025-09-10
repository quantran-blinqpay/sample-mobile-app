// ignore_for_file: must_be_immutable

import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/core/utils/color_utils.dart';
import 'package:qwid/src/core/utils/datetime.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionDetailItem extends StatelessWidget {
  DescriptionDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 21, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data?.description?.isNotEmpty ?? false)
            ReadMoreText(
              '${data?.description ?? ''} ',
              trimMode: TrimMode.Line,
              trimLines: 4,
              colorClickableText: Colors.pink,
              style: AppStyles.of(context).copyWith(
                shadows: [
                  Shadow(color: appColors!.black, offset: Offset(0, -3))
                ],
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.transparent,
              ),
              lessStyle: AppStyles.of(context).copyWith(
                shadows: [
                  Shadow(color: appColors!.black, offset: Offset(0, -3))
                ],
                color: Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
              moreStyle: AppStyles.of(context).copyWith(
                shadows: [
                  Shadow(color: appColors!.black, offset: Offset(0, -3))
                ],
                color: Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            )
          else
            Text(
              'No listing description entered',
              style: AppStyles.of(context).copyWith(
                shadows: [
                  Shadow(color: appColors!.black, offset: Offset(0, -3))
                ],
                color: Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                for (var itemColor in data?.colour?.split(',') ?? <String>[])
                  Builder(builder: (context) {
                    final hexColor =
                        ColorUtils.hexKeyFromLabelString(itemColor);
                    final color = itemColor.toLowerCase() != 'various'
                        ? Color(int.parse(hexColor!.substring(1), radix: 16) +
                            0xFF000000)
                        : Colors.transparent;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: itemColor.toLowerCase() == 'various'
                                ? null
                                : color,
                            gradient: itemColor.toLowerCase() == 'various'
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
                        SizedBox(width: 10),
                        Text(
                          itemColor,
                          style: AppStyles.of(context).copyWith(
                            color: appColors!.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }),
              ],
            ),
          ),
          Text(
            'LISTED ${DateTimeUtil.getRelativeTime(
              data?.detail?.data?.renewedAt?.date ?? DateTime.now(),
            )}'
                .toUpperCase(),
            style: AppStyles.of(context).copyWith(
              color: appColors!.black,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
