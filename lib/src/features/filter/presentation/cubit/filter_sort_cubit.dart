import 'package:collection/collection.dart';
import 'package:designerwardrobe/src/core/constants/app_constants.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_hits_dto.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/my_size_response.dart';
import 'package:designerwardrobe/src/features/filter/domain/respositories/filter_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'filter_sort_state.dart';

class FilterSortCubit extends Cubit<FilterSortState> {
  FilterSortCubit(this.repository) : super(FilterSortState());

  final FilterRepository repository;
  final dataStartup = GetIt.instance<HelperCubit>().state.startup;

  Future<void> initData() async {
    await initDataFirstLoad();
    await onFilter();
  }

  Future<void> onFilter({bool showLoading = true}) async {
    state.currentPage = 0;
    state.canLoadMoreItems = true;

    if (showLoading) {
      emit(state.copyWith(fetchFilterStatus: ProgressStatus.inProgress));
    }

    final response = await repository.search(
      state.currentPage,
      sort: state.selectedSortBy.id,
      textSearch: state.searchText,
      categories: state.selectedCategory?.urlTitle,
      brands: state.selectedBrands?.isNotEmpty ?? false
          ? state.selectedBrands!.map((e) => e.urlTitle ?? '').toList()
          : null,
      // sizes: state.selectedSizes?.join(','),
      colour: state.selectedColours?.isNotEmpty ?? false
          ? state.selectedColours!.map((e) => e.name ?? '').toList()
          : null,
      priceRanges: ((state.priceFrom?.isNotEmpty ?? false) ||
              (state.priceTo?.isNotEmpty ?? false))
          ? '${state.priceFrom}-${state.priceTo}'
          : null,
      minDiscount:
          state.selectedDiscount.id != 'All' ? state.selectedDiscount.id : null,
      condition: state.selectedConditions?.isNotEmpty ?? false
          ? state.selectedConditions!.map((e) => e.id ?? '').toList()
          : null,
      location: state.selectedItemLocation?.id,
    );
    response.fold((error) {
      emit(state.copyWith(fetchFilterStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      state.currentPage++;

      emit(state.copyWith(
        searchItems: data.hits ?? [],
        canLoadMoreItems: true,
        currentPage: state.currentPage,
        totalResult: data.nbHits,
        fetchFilterStatus: ProgressStatus.success,
      ));

      if (data.hits?.isEmpty ?? true) {
        state.refreshController.loadNoData();
      } else {
        state.refreshController.loadComplete();
      }
    });
  }

  Future<void> onLoadmore() async {
    final response = await repository.search(
      state.currentPage,
      sort: state.selectedSortBy.id,
      textSearch: state.searchText,
      categories: state.selectedCategory?.urlTitle,
      brands: state.selectedBrands?.isNotEmpty ?? false
          ? state.selectedBrands!.map((e) => e.urlTitle ?? '').toList()
          : null,
      // sizes: state.selectedSizes?.join(','),
      colour: state.selectedColours?.isNotEmpty ?? false
          ? state.selectedColours!.map((e) => e.name ?? '').toList()
          : null,
      priceRanges: ((state.priceFrom?.isNotEmpty ?? false) ||
              (state.priceTo?.isNotEmpty ?? false))
          ? '${state.priceFrom}-${state.priceTo}'
          : null,
      minDiscount:
          state.selectedDiscount.id != 'All' ? state.selectedDiscount.id : null,
      condition: state.selectedConditions?.isNotEmpty ?? false
          ? state.selectedConditions!.map((e) => e.id ?? '').toList()
          : null,
      location: state.selectedItemLocation?.id,
    );
    response.fold((error) {
      emit(state.copyWith(fetchFilterStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      final current = state.searchItems ?? [];
      final newItems = List<FilterHitsDto>.from(current)
        ..addAll(data.hits ?? []);
      state.currentPage++;

      emit(state.copyWith(
        searchItems: newItems,
        canLoadMoreItems: data.hits?.isNotEmpty ?? false,
        currentPage: state.currentPage,
      ));

      if (data.hits?.isEmpty ?? true) {
        state.refreshController.loadNoData();
      } else {
        state.refreshController.loadComplete();
      }
    });
  }

  Future<void> initDataFirstLoad() async {
    final cateWomen =
        dataStartup?.categories?.firstWhereOrNull((e) => e.id == 2);
    final dataBrand = dataStartup?.brands?.women?.toBrandItemList();

    emit(state.copyWith(
      dataBrand: dataBrand,
      mainCategory: cateWomen?.urlTitle,
      selectedCategory: FilterClass(
        id: cateWomen?.id.toString(),
        name: cateWomen?.title,
        urlTitle: cateWomen?.urlTitle,
      ),
      fetchStartupStatus: ProgressStatus.success,
    ));
  }

  Future<void> getMySizes() async {
    final response = await repository.getMySize();
    response.fold((error) {
      emit(state.copyWith(fetchSizesStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataMySizes: data,
        fetchSizesStatus: ProgressStatus.success,
      ));
    });
  }

  void clearAll() {
    final cateWomen =
        dataStartup?.categories?.firstWhereOrNull((e) => e.id == 2);
    final dataBrand = dataStartup?.brands?.women?.toBrandItemList();

    emit(state.copyWith(
      dataBrand: dataBrand,
      selectedSortBy: FilterClass(id: 'relevance', name: 'Relevance'),
      mainCategory: cateWomen?.urlTitle,
      selectedCategory: FilterClass(
        id: cateWomen?.id.toString(),
        name: cateWomen?.title,
        urlTitle: cateWomen?.urlTitle,
      ),
      selectedBrands: [],
      turnOnMySize: false,
      alwaysFilterByMySize: false,
      selectedSizes: [],
      selectedColours: [],
      priceFrom: '',
      priceTo: '',
      selectedDiscount: FilterClass(id: 'All', name: 'All'),
      selectedConditions: [],
      selectedItemLocation: FilterClass(),
      canLoadMoreItems: true,
    ));
    onFilter();
  }

  void updateSearchText(String value) {
    emit(state.copyWith(searchText: value));
  }

  void onSelectSortBy(FilterClass value) {
    emit(state.copyWith(selectedSortBy: value));
    onFilter();
  }

  void initBrands() {
    List<FilterClass>? temp = getBrandByCatogory(state.mainCategory);
    emit(state.copyWith(dataBrand: temp));
  }

  void onSelectCategory(
    FilterClass? value, {
    bool isClear = false,
    String? mainCategory,
  }) {
    if (isClear) {
      final dataBrand = dataStartup?.brands?.women?.toBrandItemList();
      final cateWomen =
          dataStartup?.categories?.firstWhereOrNull((e) => e.id == 2);

      emit(state.copyWith(
        mainCategory: cateWomen?.urlTitle,
        dataBrand: dataBrand,
        selectedBrands: [],
        selectedCategory: FilterClass(
          id: cateWomen?.id.toString(),
          name: cateWomen?.title,
          urlTitle: cateWomen?.urlTitle,
        ),
      ));

      onFilter();
      return;
    }

    if (mainCategory?.isNotEmpty ?? false) {
      List<FilterClass>? temp = getBrandByCatogory(mainCategory);

      emit(state.copyWith(
        selectedCategory: value,
        mainCategory: mainCategory,
        selectedBrands: [],
        dataBrand: temp,
      ));
    } else {
      emit(state.copyWith(selectedCategory: value));
    }
    onFilter();
  }

  List<FilterClass>? getBrandByCatogory(String? mainCategory) {
    List<FilterClass>? temp = [];

    /// Moi Category se ung voi mot brand rieng
    switch (mainCategory) {
      case KFilterBrandCategory.women:
        temp = dataStartup?.brands?.women?.toBrandItemList();
        break;
      case KFilterBrandCategory.men:
        temp = dataStartup?.brands?.men?.toBrandItemList();
        break;
      case KFilterBrandCategory.beauty:
        temp = dataStartup?.brands?.beautyWellness?.toBrandItemList();
        break;
      case KFilterBrandCategory.home:
        temp = dataStartup?.brands?.home?.toBrandItemList();
        break;
      case KFilterBrandCategory.kids:
        temp = dataStartup?.brands?.kids?.toBrandItemList();
        break;
      default:
        temp = [];
    }
    return temp;
  }

  void onSearchBand(String textSearch) {
    final searchedItem = List<FilterClass>.from(
        dataStartup?.brands?.women?.toBrandItemList().where(
              (e) {
                return e.name
                        ?.toLowerCase()
                        .contains(textSearch.trim().toLowerCase()) ??
                    false;
              },
            ).toList() ??
            []);

    emit(state.copyWith(dataBrand: searchedItem));
  }

  void onSelectBrand(FilterClass? value, {bool isClear = false}) {
    if (isClear) {
      emit(state.copyWith(selectedBrands: []));
      onFilter();
      return;
    }

    final temp =
        List<FilterClass>.from(state.selectedBrands ?? <FilterClass>[]);

    if (temp.any((e) => e.id == value?.id)) {
      temp.removeWhere((e) => e.id == value?.id);
    } else {
      temp.add(value!);
    }

    if (!ListEquality().equals(temp, state.selectedBrands)) {
      emit(state.copyWith(selectedBrands: temp));
      onFilter();
    }
  }

  void toggleTurnOnMySize(bool value) {
    emit(state.copyWith(turnOnMySize: value));
  }

  void toggleAlwaysFilterByMySize(bool value) {
    emit(state.copyWith(alwaysFilterByMySize: value));
  }

  void onSaveSizes(List<FilterClass> values) {
    emit(state.copyWith(selectedSizes: values));
  }

  void onSelectColour(FilterClass? value, {bool isClear = false}) {
    if (isClear) {
      emit(state.copyWith(selectedColours: []));
      onFilter();
      return;
    }

    final temp =
        List<FilterClass>.from(state.selectedColours ?? <FilterClass>[]);

    if (temp.any((e) => e.id == value?.id)) {
      temp.removeWhere((e) => e.id == value?.id);
    } else {
      temp.add(value!);
    }

    if (!ListEquality().equals(temp, state.selectedColours)) {
      emit(state.copyWith(selectedColours: temp));
      onFilter();
    }
  }

  void onSelectPrice(String from, String to) {
    emit(state.copyWith(priceFrom: from, priceTo: to));
    onFilter();
  }

  void onSelectDiscount(FilterClass value) {
    emit(state.copyWith(selectedDiscount: value));
    onFilter();
  }

  void onSelectCondition(FilterClass? value, {bool isClear = false}) {
    if (isClear) {
      emit(state.copyWith(selectedConditions: []));
      onFilter();
      return;
    }

    final temp =
        List<FilterClass>.from(state.selectedConditions ?? <FilterClass>[]);

    if (temp.any((e) => e.id == value?.id)) {
      temp.removeWhere((e) => e.id == value?.id);
    } else {
      temp.add(value!);
    }

    if (!ListEquality().equals(temp, state.selectedConditions)) {
      emit(state.copyWith(selectedConditions: temp));
      onFilter();
    }
  }

  void onSelectItemLocation(FilterClass value) {
    emit(state.copyWith(selectedItemLocation: value));
    onFilter();
  }

  @override
  Future<void> close() {
    super.emit(FilterSortState());
    return super.close();
  }
}
