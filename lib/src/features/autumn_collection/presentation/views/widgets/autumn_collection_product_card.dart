import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/extensions/amount.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AutumnCollectionProductCard extends StatelessWidget {
  const AutumnCollectionProductCard({
    required this.id,
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.size,
    required this.priceNzd,
    this.originalPrice,
    this.salePriceNz,
    this.isSale = false,
    this.numberOfWatchers,
    super.key,
  });

  final int? id;
  final String? imageUrl;
  final String? brand;
  final String? title;
  final String? size;
  final double? priceNzd;
  final double? originalPrice;
  final double? salePriceNz;
  final bool isSale;
  final int? numberOfWatchers;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    
    return GestureDetector(
      onTap: () {
        context.router.push(ItemDetailWrapperScreenRoute(id: id ?? 0));
      },
      child: Container(
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tags
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: AspectRatio(
                      aspectRatio: 136 / 148,
                      child: AppImage(
                        imageUrl: imageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Sale tag
                  if (isSale)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: appColors.brightRed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'SALE',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: appColors.white,
                          ),
                        ),
                      ),
                    ),
                  // Autumn Collection tag
                  Positioned(
                    top: isSale ? 28 : 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'AUTUMN',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: appColors.white,
                        ),
                      ),
                    ),
                  ),
                  // Wishlist icon
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Implement wishlist toggle
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: appColors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          icLiked,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand name
                    if (brand?.isNotEmpty == true)
                      Text(
                        brand!,
                        style: AppStyles.of(context).copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: appColors.silverSand,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    // Product title
                    Text(
                      title ?? '',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: appColors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Size
                    if (size?.isNotEmpty == true)
                      Text(
                        'Size: $size',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: appColors.silverSand,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    // Price section
                    _buildPriceSection(context, appColors),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context, AppColors appColors) {
    if (isSale && salePriceNz != null && originalPrice != null) {
      // Calculate discount percentage
      final discountPercent = ((originalPrice! - salePriceNz!) / originalPrice! * 100).round();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                salePriceNz!.asNZDFormat(),
                style: AppStyles.of(context).copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: appColors.brightRed,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                originalPrice!.asNZDFormat(),
                style: AppStyles.of(context).copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: appColors.silverSand,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Text(
            '$discountPercent% off',
            style: AppStyles.of(context).copyWith(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: appColors.brightRed,
            ),
          ),
        ],
      );
    } else {
      // Regular price
      return Text(
        (priceNzd ?? 0.0).asNZDFormat(),
        style: AppStyles.of(context).copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: appColors.black,
        ),
      );
    }
  }
}
