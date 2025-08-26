import 'dart:async';

import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/autumn_collection/domain/repositories/autumn_collection_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'autumn_collection_state.dart';

class AutumnCollectionCubit extends Cubit<AutumnCollectionState> {
  AutumnCollectionCubit({
    required AutumnCollectionRepository autumnCollectionRepository,
  })  : _autumnCollectionRepository = autumnCollectionRepository,
        super(AutumnCollectionState());

  final AutumnCollectionRepository _autumnCollectionRepository;

  Future<void> loadRecommendedItems() async {
    try {
      emit(state.copyWith(
        fetchRecommendedItemsStatus: ProgressStatus.inProgress,
        errorMessage: null,
      ));

      // Initialize session first
      await _autumnCollectionRepository.initializeSession();
      
      // Load recommended items
      final items = await _autumnCollectionRepository.getRecommendedItems();
      
      emit(state.copyWith(
        fetchRecommendedItemsStatus: ProgressStatus.success,
        recommendedItems: items,
        canLoadMoreItems: items.isNotEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        fetchRecommendedItemsStatus: ProgressStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadNextItems() async {
    if (!state.canLoadMoreItems || 
        state.fetchNextItemsStatus == ProgressStatus.inProgress) {
      return;
    }

    try {
      emit(state.copyWith(
        fetchNextItemsStatus: ProgressStatus.inProgress,
      ));

      final nextItems = await _autumnCollectionRepository.getNextItems();
      
      if (nextItems.isNotEmpty) {
        final List<ProductTile> updatedItems = [
          ...(state.recommendedItems ?? <ProductTile>[]),
          ...nextItems
        ];
        emit(state.copyWith(
          fetchNextItemsStatus: ProgressStatus.success,
          recommendedItems: updatedItems,
          canLoadMoreItems: nextItems.length >= 20, // Assume 20 items per page
        ));
      } else {
        emit(state.copyWith(
          fetchNextItemsStatus: ProgressStatus.success,
          canLoadMoreItems: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        fetchNextItemsStatus: ProgressStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refreshItems() async {
    emit(state.copyWith(
      recommendedItems: <ProductTile>[],
      canLoadMoreItems: true,
    ));
    await loadRecommendedItems();
  }
}
