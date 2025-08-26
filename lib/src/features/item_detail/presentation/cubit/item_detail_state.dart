// ignore_for_file: must_be_immutable

part of 'item_detail_cubit.dart';

class ItemDetailState extends Equatable {
  ItemDetailState({
    this.dataListingDetail,
    this.dataQuestion,
    this.searchItems,
    this.recommendedItems,
    this.fetchDetailStatus = ProgressStatus.initial,
    this.fetchMoreitemStatus = ProgressStatus.initial,
    this.fetchAllQuestionStatus = ProgressStatus.initial,
    this.fetchSimilarStatus = ProgressStatus.initial,
    this.fetchAskQuestionStatus = ProgressStatus.initial,
    this.totalResult = 0,
    this.recommId,
    this.isShowQuestionField = false,
    this.questionText,
  });

  final ListingDetailResponse? dataListingDetail;
  final AllQuestionResponse? dataQuestion;
  final List<FilterHitsDto>? searchItems;
  final List<ProductTile>? recommendedItems;

  final ProgressStatus fetchDetailStatus;
  final ProgressStatus? fetchMoreitemStatus;
  final ProgressStatus? fetchAllQuestionStatus;
  final ProgressStatus? fetchSimilarStatus;
  final ProgressStatus? fetchAskQuestionStatus;
  final RefreshController refreshController = RefreshController();
  int totalResult;
  final String? recommId;
  bool isShowQuestionField;
  String? questionText;

  ItemDetailState copyWith({
    ListingDetailResponse? dataListingDetail,
    AllQuestionResponse? dataQuestion,
    List<FilterHitsDto>? searchItems,
    List<ProductTile>? recommendedItems,
    ProgressStatus? fetchDetailStatus,
    ProgressStatus? fetchMoreitemStatus,
    ProgressStatus? fetchAllQuestionStatus,
    ProgressStatus? fetchSimilarStatus,
    ProgressStatus? fetchAskQuestionStatus,
    int? totalResult,
    String? recommId,
    bool? isShowQuestionField,
    String? questionText,
  }) {
    return ItemDetailState(
      dataListingDetail: dataListingDetail ?? this.dataListingDetail,
      dataQuestion: dataQuestion ?? this.dataQuestion,
      searchItems: searchItems ?? this.searchItems,
      recommendedItems: recommendedItems ?? this.recommendedItems,
      fetchDetailStatus: fetchDetailStatus ?? this.fetchDetailStatus,
      fetchMoreitemStatus: fetchMoreitemStatus ?? this.fetchMoreitemStatus,
      fetchAllQuestionStatus:
          fetchAllQuestionStatus ?? this.fetchAllQuestionStatus,
      fetchSimilarStatus: fetchSimilarStatus ?? this.fetchSimilarStatus,
      fetchAskQuestionStatus:
          fetchAskQuestionStatus ?? this.fetchAskQuestionStatus,
      totalResult: totalResult ?? this.totalResult,
      recommId: recommId ?? this.recommId,
      isShowQuestionField: isShowQuestionField ?? this.isShowQuestionField,
      questionText: questionText ?? this.questionText,
    );
  }

  @override
  List<Object?> get props => [
        dataListingDetail,
        dataQuestion,
        searchItems,
        recommendedItems,
        fetchDetailStatus,
        fetchAllQuestionStatus,
        fetchMoreitemStatus,
        fetchSimilarStatus,
        fetchAskQuestionStatus,
        totalResult,
        recommId,
        isShowQuestionField,
        questionText,
      ];
}
