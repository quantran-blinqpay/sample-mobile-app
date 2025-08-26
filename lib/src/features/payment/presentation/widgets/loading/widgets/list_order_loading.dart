import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:flutter/material.dart';

class ListOrderLoading extends StatelessWidget {
  const ListOrderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          // Image with discount badge
          AppShimmer(
            cornerRadius: 10,
            width: 65,
            height: 65,
          ),
          const SizedBox(width: 15),
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  width: 100,
                  height: 14,
                ),
                SizedBox(height: 2),
                AppShimmer(
                  width: 100,
                  height: 12,
                ),
                SizedBox(height: 2),
                AppShimmer(
                  width: 65,
                  height: 12,
                ),
              ],
            ),
          ),
          // Price info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppShimmer(
                width: 120,
                height: 12,
              ),
              SizedBox(height: 4),
              AppShimmer(
                width: 65,
                height: 12,
              ),
            ],
          )
        ],
      ),
    );
  }

}