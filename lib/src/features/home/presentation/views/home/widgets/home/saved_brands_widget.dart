import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/filter_item_widget.dart';
import 'package:flutter/material.dart';

class SavedBrandsWidget extends StatelessWidget {
  final List<String> brands = [
    "Aje",
    "Levi’s",
    "Ganni",
    "Ruby",
    "Alémais",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand",
    "Brand"
  ];

  SavedBrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Saved Brands",
            style: TextStyle(
              fontFamily: 'FeatureDeckCondensed',
              fontSize: 20,
              color: appColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: brands.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return FilterItemWidget(brands[index]);
            },
          ),
        ),
      ],
    );
  }
}