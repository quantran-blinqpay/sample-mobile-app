import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class ForSaleView extends StatelessWidget {
  ForSaleView({super.key});

  final List<Map<String, dynamic>> items = [
    {
      'image':
      'https://www.timberland.com.my/wp-content/uploads/product/f24/A696HEW5-HERO.jpg', // replace with your image URL
      'isSold': false
    },
    {
      'image':
      'https://www.bfgcdn.com/1500_1500_90/004-5495-0311/timberland-durable-water-repellent-puffer-jacket-synthetic-jacket.jpg', // replace with your image URL
      'isSold': false
    },
    {
      'image': '',
      'isSold': true
    },
    {
      'image': '',
      'isSold': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2/3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: item['isSold'] == false && item['image'] != ''
                    ? DecorationImage(
                  image: NetworkImage(item['image']),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
            ),
            if (item['isSold'])
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                          icPlaceHolderLarge,
                          fit: BoxFit.fill,
                        ),
                    ),
                    Positioned.fill(
                      child: ColoredBox(color: appColors.black.withAlpha(80)),
                    ),
                    Center(
                      child: Text(
                        'SOLD',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

}