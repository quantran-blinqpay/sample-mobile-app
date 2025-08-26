import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/pagination/widgets/enhanced_product_card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

class PaginationProductGrid extends StatefulWidget {
  const PaginationProductGrid({
    required this.products,
    required this.canLoadMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRefresh,
    super.key,
  });

  final List<ProductTile> products;
  final bool canLoadMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;

  @override
  State<PaginationProductGrid> createState() => _PaginationProductGridState();
}

class _PaginationProductGridState extends State<PaginationProductGrid> {
  final refresh.RefreshController _refreshController = refresh.RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return refresh.SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: widget.canLoadMore,
      onRefresh: () async {
        try {
          await widget.onRefresh();
          _refreshController.refreshCompleted();
        } catch (e) {
          _refreshController.refreshFailed();
        }
      },
      onLoading: () {
        widget.onLoadMore();
        // The controller completion will be handled by the cubit
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            if (widget.canLoadMore) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadNoData();
            }
          }
        });
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns as required
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 135 / 181, // Same as RecommendedForYouWidget
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return EnhancedProductCard(
            id: int.tryParse(product.id ?? '0'),
            imageUrl: product.values?.imageUrl,
            brand: product.values?.brand,
            title: product.values?.title,
            size: product.values?.sizesStr,
            priceNzd: product.values?.priceNzd,
            originalPrice: product.values?.originalPrice?.toDouble(),
            salePriceNz: product.values?.salePriceNz?.toDouble(),
            isSale: product.values?.isSale ?? false,
            numberOfWatchers: product.values?.numberOfWatchers,
          );
        },
      ),
    );
  }
}
