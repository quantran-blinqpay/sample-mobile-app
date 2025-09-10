import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/features/home/data/remote/dtos/watchlist/watchlist_data.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/home/brand_item_widget.dart';
import 'package:flutter/material.dart';

class WatchlistSectionWidget extends StatelessWidget {
  const WatchlistSectionWidget({required this.items, super.key});

  final List<WatchlistData> items;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Watchlist",
                style: TextStyle(
                  fontFamily: 'FeatureDeckCondensed',
                  fontSize: 20,
                  color: appColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "See all",
                style: AppStyles.of(context).copyWith(
                  fontSize: 11,
                  color: appColors.cobatBlue,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Horizontal list
        SizedBox(
          height: 231,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return BrandItemWidget(
                id: items[index].id,
                imageUrl: items[index].url,
                title: items[index].title,
                priceNzd: items[index].priceNzd?.toDouble(),
              );
            },
          ),
        ),
      ],
    );
  }
}
