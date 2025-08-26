import 'dart:async';

import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/parameters/make_offer_parameter.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/helper/dtos/site_setting_data.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import '../../domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState());

  final HomeRepository repository;

  Future<String> loadRecombeeSession() async {
    final c = Completer<String>();
    final response = await repository.loadRecombeeSession();
    response.fold((error) {
      emit(state.copyWith(fetchRecombeeSession: ProgressStatus.failure));
      c.complete('');
    }, (data) {
      emit(state.copyWith(
        fetchRecombeeSession: ProgressStatus.success,
        sessionId: data,
        recommId: '',
      ));
      c.complete(data);
    });
    return c.future;
  }

  Future<void> loadRecommendedItems() async {
    emit(
        state.copyWith(fetchRecommendedItemsStatus: ProgressStatus.inProgress));
    var sessionId = state.sessionId ?? '';
    if (sessionId.isEmpty) {
      sessionId = await loadRecombeeSession();
    }
    final response =
        await repository.loadRecommendedItems(state.sessionId ?? '');
    response.fold((error) {
      emit(state.copyWith(fetchRecommendedItemsStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      emit(state.copyWith(
        fetchRecommendedItemsStatus: ProgressStatus.success,
        recommendedItems: data?.recomms ?? [],
        recommId: data?.recommId,
        canLoadMoreItems: true,
      ));
      if (data?.recomms?.isEmpty ?? true) {
        state.refreshController.loadNoData();
      } else {
        state.refreshController.loadComplete();
      }
    });
  }

  Future<void> loadNextItems() async {
    debugPrint('quanth: loadNextItems was called');
    emit(state.copyWith(fetchNextItemsStatus: ProgressStatus.inProgress));
    var sessionId = state.sessionId ?? '';
    if (sessionId.isEmpty) {
      sessionId = await loadRecombeeSession();
    }
    final response = await repository.loadNextItems(state.recommId ?? '');
    response.fold((error) {
      emit(state.copyWith(fetchNextItemsStatus: ProgressStatus.failure));
      state.refreshController.loadFailed();
    }, (data) {
      state.recommendedItems?.addAll(data?.recomms ?? []);
      emit(state.copyWith(
          fetchNextItemsStatus: ProgressStatus.success,
          recommendedItems: state.recommendedItems,
          recommId: data?.recommId,
          canLoadMoreItems: data?.recomms?.isNotEmpty ?? false));
      if (data?.recomms?.isEmpty ?? true) {
        state.refreshController.loadNoData();
      } else {
        state.refreshController.loadComplete();
      }
    });
  }

  Future<void> loadAllSiteSettings() async {
    emit(state.copyWith(fetchSiteSettingStatus: ProgressStatus.inProgress));
    final response = await repository.loadAllSiteSettings();
    response.fold((error) {
      emit(state.copyWith(fetchSiteSettingStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        fetchSiteSettingStatus: ProgressStatus.success,
        siteSetting: data,
      ));
    });
  }

  Future<void> loadWatchList() async {
    emit(state.copyWith(fetchWatchlistStatus: ProgressStatus.inProgress));
    final response = await repository.loadWatchList();
    response.fold((error) {
      emit(state.copyWith(fetchWatchlistStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        fetchWatchlistStatus: ProgressStatus.success,
        watchlistItem: data,
      ));
    });
  }

  Future<void> loadLoveItems() async {
    emit(state.copyWith(fetchMoreWithLovesStatus: ProgressStatus.inProgress));
    var sessionId = state.sessionId ?? '';
    if (sessionId.isEmpty) {
      sessionId = await loadRecombeeSession();
    }
    final response =
        await repository.loadRecommendedItems(state.sessionId ?? '');
    response.fold((error) {
      emit(state.copyWith(fetchMoreWithLovesStatus: ProgressStatus.failure));
      state.refreshLoveController.loadFailed();
    }, (data) {
      emit(state.copyWith(
        fetchMoreWithLovesStatus: ProgressStatus.success,
        moreWithLoves: data?.recomms ?? [],
        recommId: data?.recommId,
        canLoadMoreLoveItems: true,
      ));
      if (data?.recomms?.isEmpty ?? true) {
        state.refreshLoveController.loadNoData();
      } else {
        state.refreshLoveController.loadComplete();
      }
    });
  }

  Future<void> loadNextLoveItems() async {
    debugPrint('quanth: loadNextItems was called');
    emit(state.copyWith(fetchNextLoveItemsStatus: ProgressStatus.inProgress));
    var sessionId = state.sessionId ?? '';
    if (sessionId.isEmpty) {
      sessionId = await loadRecombeeSession();
    }
    final response = await repository.loadNextItems(state.recommId ?? '');
    response.fold((error) {
      emit(state.copyWith(fetchNextLoveItemsStatus: ProgressStatus.failure));
      state.refreshLoveController.loadFailed();
    }, (data) {
      state.moreWithLoves?.addAll(data?.recomms ?? []);
      emit(state.copyWith(
          fetchNextLoveItemsStatus: ProgressStatus.success,
          moreWithLoves: state.moreWithLoves,
          recommId: data?.recommId,
          canLoadMoreLoveItems: data?.recomms?.isNotEmpty ?? false));
      if (data?.recomms?.isEmpty ?? true) {
        state.refreshLoveController.loadNoData();
      } else {
        state.refreshLoveController.loadComplete();
      }
    });
  }

  Future<void> makeOffer(
      {required String currency,
      required String price,
      required int listingId}) async {
    emit(state.copyWith(makeOfferStatus: ProgressStatus.inProgress));
    final response = await repository.makeOffer(MakeOfferParameter(
      listingId: listingId,
      currency: currency,
      price: price,
    ));
    response.fold((error) {
      emit(state.copyWith(makeOfferStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        makeOfferStatus: ProgressStatus.success,
      ));
    });
  }

  @override
  Future<void> close() {
    // Emit a clean initial state before closing
    emit(HomeState());
    return super.close();
  }
}
