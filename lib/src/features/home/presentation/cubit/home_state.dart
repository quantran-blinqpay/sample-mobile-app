part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({
    this.fetchRecommendedItemsStatus = ProgressStatus.initial,
    this.recommendedItems,
    this.errorMessage,
    this.fetchRecombeeSession = ProgressStatus.initial,
    this.sessionId,
    this.fetchNextItemsStatus = ProgressStatus.initial,
    this.recommId,
    this.canLoadMoreItems = true,
    this.fetchSiteSettingStatus = ProgressStatus.initial,
    this.siteSetting,
    this.fetchWatchlistStatus = ProgressStatus.initial,
    this.watchlistItem,
    this.fetchMoreWithLovesStatus = ProgressStatus.initial,
    this.moreWithLoves,
    this.canLoadMoreLoveItems = false,
    this.fetchNextLoveItemsStatus = ProgressStatus.initial,
    this.makeOfferStatus = ProgressStatus.initial,
    this.countOfferStatus = ProgressStatus.initial,
  });
  
  final ProgressStatus fetchRecommendedItemsStatus;
  final List<ProductTile>? recommendedItems;
  final String? errorMessage;

  final ProgressStatus fetchRecombeeSession;
  final String? sessionId;

  final ProgressStatus fetchNextItemsStatus;
  final String? recommId;
  final bool canLoadMoreItems;

  final refresh.RefreshController refreshController = refresh.RefreshController();
  final refresh.RefreshController refreshLoveController = refresh.RefreshController();

  final ProgressStatus fetchSiteSettingStatus;
  final SiteSettingData? siteSetting;

  final ProgressStatus fetchWatchlistStatus;
  final WatchlistItem? watchlistItem;

  final ProgressStatus fetchMoreWithLovesStatus;
  final ProgressStatus fetchNextLoveItemsStatus;
  final List<ProductTile>? moreWithLoves;
  final bool canLoadMoreLoveItems;

  final ProgressStatus makeOfferStatus;
  final ProgressStatus countOfferStatus;

  @override
  List<Object ?> get props => [
    errorMessage,
    recommendedItems,
    fetchRecommendedItemsStatus,
    fetchRecombeeSession,
    sessionId,
    fetchNextItemsStatus,
    recommId,
    canLoadMoreItems,
    fetchSiteSettingStatus,
    siteSetting,
    fetchWatchlistStatus,
    watchlistItem,
    fetchMoreWithLovesStatus,
    moreWithLoves,
    canLoadMoreLoveItems,
    fetchNextLoveItemsStatus,
    makeOfferStatus,
    countOfferStatus,
  ];

  HomeState copyWith({
    ProgressStatus? fetchRecommendedItemsStatus,
    List<ProductTile>? recommendedItems,
    String? errorMessage,
    ProgressStatus? fetchRecombeeSession,
    String? sessionId,
    ProgressStatus? fetchNextItemsStatus,
    String? recommId,
    bool? canLoadMoreItems,
    ProgressStatus? fetchSiteSettingStatus,
    SiteSettingData? siteSetting,
    ProgressStatus? fetchWatchlistStatus,
    WatchlistItem? watchlistItem,
    ProgressStatus? fetchMoreWithLovesStatus,
    List<ProductTile>? moreWithLoves,
    bool? canLoadMoreLoveItems,
    ProgressStatus? fetchNextLoveItemsStatus,
    ProgressStatus? makeOfferStatus,
    ProgressStatus? countOfferStatus,
  }) {
    return HomeState(
      fetchRecommendedItemsStatus:
          fetchRecommendedItemsStatus ?? this.fetchRecommendedItemsStatus,
      recommendedItems: recommendedItems ?? this.recommendedItems,
      errorMessage: errorMessage ?? this.errorMessage,
      fetchRecombeeSession: fetchRecombeeSession ?? this.fetchRecombeeSession,
      sessionId: sessionId ?? this.sessionId,
      fetchNextItemsStatus: fetchNextItemsStatus ?? this.fetchNextItemsStatus,
      recommId: recommId ?? this.recommId,
      canLoadMoreItems: canLoadMoreItems ?? this.canLoadMoreItems,
      fetchSiteSettingStatus:
          fetchSiteSettingStatus ?? this.fetchSiteSettingStatus,
      siteSetting: siteSetting ?? this.siteSetting,
      fetchWatchlistStatus: fetchWatchlistStatus ?? this.fetchWatchlistStatus,
      watchlistItem: watchlistItem ?? this.watchlistItem,
      fetchMoreWithLovesStatus:
          fetchMoreWithLovesStatus ?? this.fetchMoreWithLovesStatus,
      moreWithLoves: moreWithLoves ?? this.moreWithLoves,
      canLoadMoreLoveItems: canLoadMoreLoveItems ?? this.canLoadMoreLoveItems,
      fetchNextLoveItemsStatus: fetchNextLoveItemsStatus ?? this.fetchNextLoveItemsStatus,
      makeOfferStatus: makeOfferStatus ?? this.makeOfferStatus,
      countOfferStatus: countOfferStatus ?? this.countOfferStatus,
    );
  }
}
