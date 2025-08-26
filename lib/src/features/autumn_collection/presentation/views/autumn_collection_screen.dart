import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/cubit/autumn_collection_cubit.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/views/widgets/autumn_collection_product_grid.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/views/widgets/autumn_collection_loading_widget.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/views/widgets/autumn_collection_empty_widget.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/views/widgets/autumn_collection_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'AutumnCollectionScreenRoute')
class AutumnCollectionScreen extends StatefulWidget implements AutoRouteWrapper {
  const AutumnCollectionScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AutumnCollectionCubit>(
      create: (context) => di<AutumnCollectionCubit>(),
      child: this,
    );
  }

  @override
  State<AutumnCollectionScreen> createState() => _AutumnCollectionScreenState();
}

class _AutumnCollectionScreenState extends State<AutumnCollectionScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize session and load recommended items
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AutumnCollectionCubit>().loadRecommendedItems();
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
          title: 'Autumn Collection',
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<AutumnCollectionCubit, AutumnCollectionState>(
        builder: (context, state) {
          // Show loading state for initial load
          if (state.fetchRecommendedItemsStatus == ProgressStatus.inProgress &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return const AutumnCollectionLoadingWidget();
          }
          
          // Show error state
          if (state.fetchRecommendedItemsStatus == ProgressStatus.failure &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return AutumnCollectionErrorWidget(
              onRetry: () {
                context.read<AutumnCollectionCubit>().loadRecommendedItems();
              },
            );
          }
          
          // Show empty state
          if (state.fetchRecommendedItemsStatus == ProgressStatus.success &&
              (state.recommendedItems?.isEmpty ?? true)) {
            return const AutumnCollectionEmptyWidget();
          }
          
          // Show product grid with pagination
          return AutumnCollectionProductGrid(
            products: state.recommendedItems ?? [],
            canLoadMore: state.canLoadMoreItems,
            isLoadingMore: state.fetchNextItemsStatus == ProgressStatus.inProgress,
            onLoadMore: () {
              if (state.canLoadMoreItems && 
                  state.fetchNextItemsStatus != ProgressStatus.inProgress) {
                context.read<AutumnCollectionCubit>().loadNextItems();
              }
            },
            onRefresh: () async {
              await context.read<AutumnCollectionCubit>().refreshItems();
            },
          );
        },
      ),
    );
  }
}
