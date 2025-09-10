import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/image/app_image.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/extensions/amount.dart';
import 'package:qwid/src/features/home/presentation/dialogs/counter_offer.dart';
import 'package:qwid/src/features/home/presentation/dialogs/make_offer.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrandItemWidget extends StatelessWidget {
  const BrandItemWidget({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.priceNzd,
    super.key,
  });

  final int? id;
  final String? imageUrl;
  final String? title;
  final double? priceNzd;
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return GestureDetector(
      onTap: () {
        context.router.push(ItemDetailWrapperScreenRoute(id: id ?? 0));
      },
      child: SizedBox(
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 136 / 148,
              child: AppImage(imageUrl: imageUrl ?? ''),
            ),
            const SizedBox(height: 8),

            // Title & price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 26 + 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: AppStyles.of(context).copyWith(
                            color: appColors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                (priceNzd ?? 0.0).asNZDFormat(),
                                style: AppStyles.of(context).copyWith(
                                  color: appColors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      icLiked,
                      width: 26,
                      height: 26,
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
