import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/pagination/widgets/pagination_product_grid.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/pagination/widgets/pagination_loading_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/pagination/widgets/pagination_empty_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/pagination/widgets/pagination_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'PaginationScreenRoute')
class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize session and load recommended items
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadRecommendedItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: CustomAppBar(
          title: 'Recommended Products',
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Show loading state for initial load
          if (state.fetchRecommendedItemsStatus == ProgressStatus.inProgress &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return const PaginationLoadingWidget();
          }
          
          // Show error state
          if (state.fetchRecommendedItemsStatus == ProgressStatus.failure &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return PaginationErrorWidget(
              onRetry: () {
                context.read<HomeCubit>().loadRecommendedItems();
              },
            );
          }
          
          // Show empty state
          if (state.fetchRecommendedItemsStatus == ProgressStatus.success &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return const PaginationEmptyWidget();
          }
          
          // Show product grid with pagination
          return PaginationProductGrid(
            products: state.recommendedItems ?? [],
            canLoadMore: state.canLoadMoreItems,
            isLoadingMore: state.fetchNextItemsStatus == ProgressStatus.inProgress,
            onLoadMore: () {
              if (state.canLoadMoreItems && 
                  state.fetchNextItemsStatus != ProgressStatus.inProgress) {
                context.read<HomeCubit>().loadNextItems();
              }
            },
            onRefresh: () async {
              await context.read<HomeCubit>().loadRecommendedItems();
            },
          );
        },
      ),
    );
  }
}
