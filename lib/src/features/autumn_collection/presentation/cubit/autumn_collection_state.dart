part of 'autumn_collection_cubit.dart';

class AutumnCollectionState extends Equatable {
  const AutumnCollectionState({
    this.fetchRecommendedItemsStatus = ProgressStatus.initial,
    this.recommendedItems,
    this.errorMessage,
    this.fetchNextItemsStatus = ProgressStatus.initial,
    this.canLoadMoreItems = true,
  });

  final ProgressStatus fetchRecommendedItemsStatus;
  final List<ProductTile>? recommendedItems;
  final String? errorMessage;
  final ProgressStatus fetchNextItemsStatus;
  final bool canLoadMoreItems;

  @override
  List<Object?> get props => [
        fetchRecommendedItemsStatus,
        recommendedItems,
        errorMessage,
        fetchNextItemsStatus,
        canLoadMoreItems,
      ];

  AutumnCollectionState copyWith({
    ProgressStatus? fetchRecommendedItemsStatus,
    List<ProductTile>? recommendedItems,
    String? errorMessage,
    ProgressStatus? fetchNextItemsStatus,
    bool? canLoadMoreItems,
  }) {
    return AutumnCollectionState(
      fetchRecommendedItemsStatus: fetchRecommendedItemsStatus ?? this.fetchRecommendedItemsStatus,
      recommendedItems: recommendedItems ?? this.recommendedItems,
      errorMessage: errorMessage ?? this.errorMessage,
      fetchNextItemsStatus: fetchNextItemsStatus ?? this.fetchNextItemsStatus,
      canLoadMoreItems: canLoadMoreItems ?? this.canLoadMoreItems,
    );
  }
}
