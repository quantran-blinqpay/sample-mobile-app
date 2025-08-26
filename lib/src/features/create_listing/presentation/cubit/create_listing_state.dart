// ignore_for_file: must_be_immutable

part of 'create_listing_cubit.dart';

enum EnumPromoteBump { none, bump, bumpHighlight }

class CreateListingState extends Equatable {
  const CreateListingState({
    this.dataFreeBump,
    this.dataBrands,
    this.dataCondition,
    this.dataDwpost,
    this.dataAI,
    this.dataPriceRecommend,
    this.photos,
    this.isPhotosValid = true,
    this.title,
    this.describle,
    this.department,
    this.category,
    this.subCategory,
    this.secondsubCategory,
    this.brand,
    this.sizes,
    this.colours,
    this.condition,
    this.sellingPrice,
    this.originalPrice,
    this.isUseShipping = true,
    this.nzShippingPrice,
    this.auShippingPrice,
    this.selectedBump = EnumPromoteBump.none,
    this.isOfferBuyNow = true,
    this.buyerPays,
    this.youllEarn,
    this.fetchAIStatus = ProgressStatus.initial,
    this.fetchPriceStatus = ProgressStatus.initial,
    this.fetchSearchBrandsStatus = ProgressStatus.initial,
    this.fetchCreateStatus = ProgressStatus.initial,
    this.fetchDraftStatus = ProgressStatus.initial,
  });

  final GetFreeBumpResponse? dataFreeBump;

  final BuildDescByAiResponse? dataAI;
  final GetPriceRecommendResponse? dataPriceRecommend;
  final List<SearchBrandsResponse>? dataBrands;
  final List<FilterItemResponse>? dataCondition;
  final GetDwpostFreightResponse? dataDwpost;

  final List<PhotoEntry>? photos;
  final bool? isPhotosValid;

  final String? title;
  final String? describle;
  final GetCategoryResponse? department;
  final GetCategoryResponse? category;
  final GetCategoryResponse? subCategory;
  final GetCategoryResponse? secondsubCategory;

  final SearchBrandsResponse? brand;
  final List<FilterSizeResponse>? sizes;
  final List<FilterClass>? colours;
  final FilterItemResponse? condition;

  final String? sellingPrice;
  final String? originalPrice;

  final bool? isUseShipping;
  final String? nzShippingPrice;
  final String? auShippingPrice;

  final EnumPromoteBump? selectedBump;

  final bool? isOfferBuyNow;

  final String? buyerPays;
  final String? youllEarn;

  final ProgressStatus fetchAIStatus;
  final ProgressStatus fetchPriceStatus;
  final ProgressStatus fetchSearchBrandsStatus;
  final ProgressStatus fetchCreateStatus;
  final ProgressStatus fetchDraftStatus;

  CreateListingState copyWith({
    GetFreeBumpResponse? dataFreeBump,
    List<SearchBrandsResponse>? dataBrands,
    List<FilterItemResponse>? dataCondition,
    GetDwpostFreightResponse? dataDwpost,
    BuildDescByAiResponse? dataAI,
    GetPriceRecommendResponse? dataPriceRecommend,
    List<PhotoEntry>? photos,
    bool? isPhotosValid,
    String? title,
    String? describle,
    GetCategoryResponse? department,
    GetCategoryResponse? category,
    GetCategoryResponse? subCategory,
    GetCategoryResponse? secondsubCategory,
    SearchBrandsResponse? brand,
    List<FilterSizeResponse>? sizes,
    List<FilterClass>? colours,
    FilterItemResponse? condition,
    String? sellingPrice,
    String? originalPrice,
    bool? isUseShipping,
    String? nzShippingPrice,
    String? auShippingPrice,
    EnumPromoteBump? selectedBump,
    bool? isOfferBuyNow,
    String? buyerPays,
    String? youllEarn,
    ProgressStatus? fetchAIStatus,
    ProgressStatus? fetchPriceStatus,
    ProgressStatus? fetchSearchBrandsStatus,
    ProgressStatus? fetchCreateStatus,
    ProgressStatus? fetchDraftStatus,
  }) {
    return CreateListingState(
      dataFreeBump: dataFreeBump ?? this.dataFreeBump,
      dataBrands: dataBrands ?? this.dataBrands,
      dataCondition: dataCondition ?? this.dataCondition,
      dataDwpost: dataDwpost ?? this.dataDwpost,
      dataAI: dataAI ?? this.dataAI,
      dataPriceRecommend: dataPriceRecommend ?? this.dataPriceRecommend,
      photos: photos ?? this.photos,
      isPhotosValid: isPhotosValid ?? this.isPhotosValid,
      title: title ?? this.title,
      describle: describle ?? this.describle,
      department: department ?? this.department,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      secondsubCategory: secondsubCategory ?? this.secondsubCategory,
      brand: brand ?? this.brand,
      sizes: sizes ?? this.sizes,
      colours: colours ?? this.colours,
      condition: condition ?? this.condition,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      isUseShipping: isUseShipping ?? this.isUseShipping,
      nzShippingPrice: nzShippingPrice ?? this.nzShippingPrice,
      auShippingPrice: auShippingPrice ?? this.auShippingPrice,
      selectedBump: selectedBump ?? this.selectedBump,
      isOfferBuyNow: isOfferBuyNow ?? this.isOfferBuyNow,
      buyerPays: buyerPays ?? this.buyerPays,
      youllEarn: youllEarn ?? this.youllEarn,
      fetchAIStatus: fetchAIStatus ?? this.fetchAIStatus,
      fetchPriceStatus: fetchPriceStatus ?? this.fetchPriceStatus,
      fetchSearchBrandsStatus:
          fetchSearchBrandsStatus ?? this.fetchSearchBrandsStatus,
      fetchCreateStatus: fetchCreateStatus ?? this.fetchCreateStatus,
      fetchDraftStatus: fetchDraftStatus ?? this.fetchDraftStatus,
    );
  }

  @override
  List<Object?> get props => [
        dataFreeBump,
        dataBrands,
        dataCondition,
        dataDwpost,
        dataAI,
        dataPriceRecommend,
        photos,
        isPhotosValid,
        title,
        describle,
        department,
        category,
        subCategory,
        secondsubCategory,
        brand,
        sizes,
        colours,
        condition,
        sellingPrice,
        originalPrice,
        isUseShipping,
        nzShippingPrice,
        auShippingPrice,
        selectedBump,
        isOfferBuyNow,
        buyerPays,
        youllEarn,
        fetchAIStatus,
        fetchPriceStatus,
        fetchSearchBrandsStatus,
        fetchCreateStatus,
        fetchDraftStatus,
      ];
}
