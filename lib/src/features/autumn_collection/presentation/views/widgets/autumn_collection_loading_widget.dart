import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';

class AutumnCollectionLoadingWidget extends StatelessWidget {
  const AutumnCollectionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 135 / 181,
        ),
        itemCount: 8, // Show 8 skeleton items
        itemBuilder: (context, index) {
          return _buildSkeletonCard(context, appColors);
        },
      ),
    );
  }

  Widget _buildSkeletonCard(BuildContext context, AppColors appColors) {
    return Container(
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
          // Image skeleton
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: AppShimmer(
                width: double.infinity,
                height: double.infinity,
                cornerRadius: 8,
              ),
            ),
          ),
          // Content skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand skeleton
                  AppShimmer(
                    width: 60,
                    height: 10,
                    cornerRadius: 4,
                  ),
                  const SizedBox(height: 4),
                  // Title skeleton
                  AppShimmer(
                    width: double.infinity,
                    height: 12,
                    cornerRadius: 4,
                  ),
                  const SizedBox(height: 2),
                  AppShimmer(
                    width: 80,
                    height: 12,
                    cornerRadius: 4,
                  ),
                  const SizedBox(height: 4),
                  // Size skeleton
                  AppShimmer(
                    width: 40,
                    height: 10,
                    cornerRadius: 4,
                  ),
                  const Spacer(),
                  // Price skeleton
                  AppShimmer(
                    width: 50,
                    height: 12,
                    cornerRadius: 4,
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
