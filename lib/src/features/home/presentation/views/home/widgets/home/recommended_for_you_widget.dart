import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:flutter/material.dart';

import 'brand_item_widget.dart';

class RecommendedForYouWidget extends StatefulWidget {
  const RecommendedForYouWidget({required this.items, super.key});

  final List<ProductTile> items;

  @override
  State<RecommendedForYouWidget> createState() => _RecommentForYouWidgetState();
}

class _RecommentForYouWidgetState extends State<RecommendedForYouWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return BrandItemWidget(
            id: int.tryParse(widget.items[index].id ?? '0'),
            imageUrl: widget.items[index].values?.imageUrl,
            title: widget.items[index].values?.title,
            priceNzd: widget.items[index].values?.priceNzd,
          );
        },
        childCount: widget.items.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of columns
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 135 / 181),
    );
  }
}
