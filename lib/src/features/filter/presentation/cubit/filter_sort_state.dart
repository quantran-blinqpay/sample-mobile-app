// ignore_for_file: must_be_immutable

part of 'filter_sort_cubit.dart';

class FilterSortState extends Equatable {
  FilterSortState({
    this.searchItems,
    this.dataMySizes,
    this.dataBrand,
    FilterClass? selectedSortBy,
    this.mainCategory,
    this.selectedCategory,
    this.selectedBrands,
    this.turnOnMySize,
    this.selectedSizes,
    this.alwaysFilterByMySize,
    this.selectedColours,
    this.priceFrom,
    this.priceTo,
    FilterClass? selectedDiscount,
    this.selectedConditions,
    this.selectedItemLocation,
    this.fetchFilterStatus = ProgressStatus.initial,
    this.fetchSizesStatus = ProgressStatus.initial,
    this.canLoadMoreItems = true,
    this.currentPage = 0,
    this.totalResult = 0,
    this.searchText,
  })  : selectedSortBy = selectedSortBy ?? dataSortBy.first,
        selectedDiscount = selectedDiscount ?? dataDiscount.first;

  final List<FilterHitsDto>? searchItems;
  final MySizeResponse? dataMySizes;
  final List<FilterClass>? dataBrand;
  final FilterClass selectedSortBy;
  final String? mainCategory;
  final FilterClass? selectedCategory;
  final List<FilterClass>? selectedBrands;
  final bool? turnOnMySize;
  final List<FilterClass>? selectedSizes;
  final bool? alwaysFilterByMySize;
  final List<FilterClass>? selectedColours;
  final String? priceFrom;
  final String? priceTo;
  final FilterClass selectedDiscount;
  final List<FilterClass>? selectedConditions;
  final FilterClass? selectedItemLocation;

  final ProgressStatus fetchFilterStatus;
  final ProgressStatus fetchSizesStatus;
  int currentPage = 0;
  bool canLoadMoreItems;
  int totalResult;
  final RefreshController refreshController = RefreshController();
  final String? searchText;

  bool isFiltered() {
    return (selectedBrands != null && selectedBrands!.isNotEmpty) ||
        ((turnOnMySize == true || alwaysFilterByMySize == true) &&
            (selectedSizes != null && selectedSizes!.isNotEmpty)) ||
        (selectedColours != null && selectedColours!.isNotEmpty) ||
        (priceFrom?.isNotEmpty ?? false) ||
        (priceTo?.isNotEmpty ?? false) ||
        ((selectedDiscount.id ?? '') != 'All') ||
        (selectedConditions != null && selectedConditions!.isNotEmpty) ||
        (selectedItemLocation?.id?.isNotEmpty ?? false);
  }

  bool checkFilteredForEachType(String id) {
    switch (id) {
      case 'CATEGORY':
        return (selectedCategory?.id?.isNotEmpty ?? false);
      case 'BRAND':
        return (selectedBrands != null && selectedBrands!.isNotEmpty);
      case 'SIZE':
        return (turnOnMySize == true) &&
            (selectedSizes != null && selectedSizes!.isNotEmpty);
      case 'COLOUR':
        return (selectedColours != null && selectedColours!.isNotEmpty);
      case 'PRICE':
        return (priceFrom?.isNotEmpty ?? false) ||
            (priceTo?.isNotEmpty ?? false);
      case 'DISCOUNT':
        return (selectedDiscount.id != 'All');
      case 'CONDITION':
        return (selectedConditions != null && selectedConditions!.isNotEmpty);
      case 'ITEMLOCATION':
        return (selectedItemLocation?.id?.isNotEmpty ?? false);

      default:
        return false;
    }
  }

  FilterSortState copyWith({
    List<FilterHitsDto>? searchItems,
    List<FilterClass>? dataBrand,
    MySizeResponse? dataMySizes,
    FilterClass? selectedSortBy,
    String? mainCategory,
    FilterClass? selectedCategory,
    List<FilterClass>? selectedBrands,
    bool? turnOnMySize,
    List<FilterClass>? selectedSizes,
    bool? alwaysFilterByMySize,
    List<FilterClass>? selectedColours,
    String? priceFrom,
    String? priceTo,
    FilterClass? selectedDiscount,
    List<FilterClass>? selectedConditions,
    FilterClass? selectedItemLocation,
    ProgressStatus? fetchFilterStatus,
    ProgressStatus? fetchStartupStatus,
    ProgressStatus? fetchSizesStatus,
    bool? canLoadMoreItems,
    int? currentPage,
    int? totalResult,
    String? searchText,
  }) {
    return FilterSortState(
      searchItems: searchItems ?? this.searchItems,
      dataBrand: dataBrand ?? this.dataBrand,
      dataMySizes: dataMySizes ?? this.dataMySizes,
      selectedSortBy: selectedSortBy ?? this.selectedSortBy,
      mainCategory: mainCategory ?? this.mainCategory,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      turnOnMySize: turnOnMySize ?? this.turnOnMySize,
      selectedSizes: selectedSizes ?? this.selectedSizes,
      alwaysFilterByMySize: alwaysFilterByMySize ?? this.alwaysFilterByMySize,
      selectedColours: selectedColours ?? this.selectedColours,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      selectedDiscount: selectedDiscount ?? this.selectedDiscount,
      selectedConditions: selectedConditions ?? this.selectedConditions,
      selectedItemLocation: selectedItemLocation ?? this.selectedItemLocation,
      fetchFilterStatus: fetchFilterStatus ?? this.fetchFilterStatus,
      fetchSizesStatus: fetchSizesStatus ?? this.fetchSizesStatus,
      canLoadMoreItems: canLoadMoreItems ?? this.canLoadMoreItems,
      currentPage: currentPage ?? this.currentPage,
      totalResult: totalResult ?? this.totalResult,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
        searchItems,
        dataBrand,
        dataMySizes,
        selectedSortBy,
        mainCategory,
        selectedCategory,
        selectedBrands,
        turnOnMySize,
        selectedSizes,
        alwaysFilterByMySize,
        selectedColours,
        priceFrom,
        priceTo,
        selectedDiscount,
        selectedConditions,
        selectedItemLocation,
        fetchFilterStatus,
        fetchSizesStatus,
        canLoadMoreItems,
        currentPage,
        totalResult,
        searchText,
      ];
}
