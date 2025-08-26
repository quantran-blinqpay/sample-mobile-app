import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_hits_dto.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/all_question_response.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/item_detail/domain/respositories/item_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit(this.repository) : super(ItemDetailState());

  final ItemDetailRepository repository;

  void initData(int id) async {
    try {
      await getListingDetail(id);
      if (state.fetchDetailStatus == ProgressStatus.success) {
        await getMoreFromSeller(
            state.dataListingDetail?.data?.user?.data?.username ?? '',
            state.dataListingDetail?.data?.category?.id ?? 0);
        await getAllQuestion(id);
        await getSimilarItem(id);
      }
    } catch (_) {}
  }

  Future<void> getListingDetail(int id) async {
    emit(state.copyWith(fetchDetailStatus: ProgressStatus.inProgress));
    final response = await repository.getListingDetail(id);
    response.fold((error) {
      emit(state.copyWith(fetchDetailStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataListingDetail: data,
        fetchDetailStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> getAllQuestion(int id) async {
    emit(state.copyWith(fetchAllQuestionStatus: ProgressStatus.inProgress));
    final response = await repository.getAllQuestion(id);
    response.fold((error) {
      emit(state.copyWith(fetchAllQuestionStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataQuestion: data,
        fetchAllQuestionStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> getMoreFromSeller(String user, int categoriesId) async {
    emit(state.copyWith(fetchMoreitemStatus: ProgressStatus.inProgress));
    final response = await repository.getMoreFromSeller(user, categoriesId);
    response.fold((error) {
      emit(state.copyWith(fetchMoreitemStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      emit(state.copyWith(
        searchItems: data.hits ?? [],
        totalResult: data.nbHits,
        fetchMoreitemStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> getSimilarItem(int itemId) async {
    emit(state.copyWith(fetchSimilarStatus: ProgressStatus.inProgress));
    var sessionId = GetIt.instance<HomeCubit>().state.sessionId;
    final response = await repository.getSimilarItem(sessionId ?? '', itemId);

    response.fold((error) {
      emit(state.copyWith(fetchSimilarStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      emit(state.copyWith(
        recommendedItems: data?.recomms ?? [],
        recommId: data?.recommId,
        fetchSimilarStatus: ProgressStatus.success,
      ));

      if (data?.recomms?.isEmpty ?? true) {
        state.refreshController.loadNoData();
      } else {
        state.refreshController.loadComplete();
      }
    });
  }

  Future<void> addToFav(int id) async {
    final response = await repository.addToFav(id);
    response.fold((error) {
      debugPrint('addToFav error ${error.toString()}');
    }, (data) {
      debugPrint('addToFav success${data.toString()}');
    });
  }

  Future<void> removeFromFav(int id) async {
    final response = await repository.addToFav(id);
    response.fold((error) {
      debugPrint('addToFav error ${error.toString()}');
    }, (data) {
      debugPrint('addToFav success${data.toString()}');
    });
  }

  void toggleShowQuestionField(bool value) {
    emit(state.copyWith(isShowQuestionField: value));
  }

  void updateQuestionText(String text) {
    emit(state.copyWith(questionText: text));
  }

  Future<void> askQuestion(int id, Map<String, dynamic> body) async {
    emit(state.copyWith(fetchAskQuestionStatus: ProgressStatus.inProgress));
    final response = await repository.askQuestion(id, body);
    response.fold((error) {
      emit(state.copyWith(fetchAskQuestionStatus: ProgressStatus.failure));
      debugPrint('askQuestion error ${error.toString()}');
    }, (data) {
      emit(state.copyWith(fetchAskQuestionStatus: ProgressStatus.success));
      debugPrint('askQuestion success${data.toString()}');
    });
  }

  @override
  Future<void> close() {
    super.emit(ItemDetailState());
    return super.close();
  }
}
